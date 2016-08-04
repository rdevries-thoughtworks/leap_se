@title = "Bitmask Firewall"
@summary = "Bitmask's egress firewall to prevent traffic leakage"

# Introduction

The bitmask firewall runs on the user's client device is designed to prevent cleartext traffic from leaking from the machine and out onto the internet. It does this by:

1. block all egress internet packets except for packets with a destination of the VPN gateway(s)
2. block all egress internet packets except for packets by the user 'openvpn'
3. rewrite all DNS packets to forward to the VPN's resolver, in order to prevent DNS leaks.

The bitmask firewall does not block traffic to the local network, nor does it block any incoming packets.

The bitmask firewall is implemented in `bitmask-root`, which is a privileged helper script included in bitmask that is used for safely running certain commands as root, such as manipulating the firewall (it is also used for bringing up and down the VPN). It is automatically run by the bitmask program before openvpn is launched to prevent DNS leaks before the VPN has been brought up.

The bitmask-root application can be run directly to stop or start the firewall, and return an exit code of 0 for success, and non-zero otherwise.

Usage

    bitmask-root firewall stop
    bitmask-root firewall start [restart] GATEWAY1 GATEWAY2 ...
    bitmask-root openvpn stop
    bitmask-root openvpn start CONFIG1 CONFIG1 ...
    bitmask-root fw-email stop
    bitmask-root fw-email start uid

When starting, bitmask-root requires that the gateway is passed as an argument. It then attempts to determine the current default network device (through `ip route show`) and then it attempts to determine the ipv4/v6 local network for that device (ip address show dev DEVICE).

Once it has determined the default device and the local network, bitmask-root then runs a series of firewall manipulation commands to setup the firewall.

# Firewall rules

The 'bitmask' chain is created for both the NAT table's OUTPUT and POSTROUTING tables, and the regular OUTPUT table. It then creates the 'jump' rule at the beginning of the NAT OUTPUT/POSTROUTING and regular OUTPUT chain to force packet inspection to go through the 'bitmask' chain first.

In order to succeed at stopping any traffic leaks, the bitmask firewall OUTPUT rules are designed to do the following:

**(1)** create a bistmask chain that is fronting the NAT table's OUTPUT and POSTROUTING tables, and regular OUTPUT table:

    Chain OUTPUT (policy ACCEPT)
    target     prot opt source               destination
    bitmask    all  --  0.0.0.0/0            0.0.0.0/0

    Chain OUTPUT (policy ACCEPT)
    target     prot opt source               destination
    bitmask    all  --  0.0.0.0/0            0.0.0.0/0

    Chain POSTROUTING (policy ACCEPT)
    target     prot opt source               destination
    bitmask_postrouting  all  --  0.0.0.0/0            0.0.0.0/0

**(2)** route all ipv4 DNS over the VPN: this is done by enabling ip forwarding, allowing DNS queries to localhost, and then rewriting all the outgoing DNS packets (udp/tcp port 53) to use the VPN DNS server instead. Then masquerading is enabled so that the DNS packets rewritten by the previous DNAT rules will have the correct source IPs:

enabling ip forwarding:

    echo 1 > /proc/sys/net/ipv4/ip_forward

allowing DNS queries to localhost:

    Chain bitmask (1 references)
    target     prot opt source               destination
    ACCEPT     udp  --  0.0.0.0/0            127.0.1.1            udp dpt:53
    ACCEPT     udp  --  0.0.0.0/0            127.0.0.1            udp dpt:53

rewriting all the outgoing DNS packets to use the VPN DNS server instead:

    Chain bitmask (1 references)
    target     prot opt source               destination
    DNAT       udp  --  0.0.0.0/0            0.0.0.0/0            udp dpt:53 to:10.42.0.1:53
    DNAT       tcp  --  0.0.0.0/0            0.0.0.0/0            tcp dpt:53 to:10.42.0.1:53

Then masquerading is enabled so that the DNS packets rewritten by the previous DNAT rules will have the correct source IPs:

    Chain bitmask_postrouting (1 references)
    target     prot opt source               destination
    MASQUERADE  udp  --  0.0.0.0/0            0.0.0.0/0            udp dpt:53
    MASQUERADE  tcp  --  0.0.0.0/0            0.0.0.0/0

**(3)** allow all local network traffic: any traffic destined for the local ipv4 network, over the default device is accepted, as well as local network sources for DNS.

    Chain bitmask (1 references)
    target     prot opt source               destination
    ACCEPT     all  --  0.0.0.0/0            192.168.1.0/24
    ACCEPT     udp  --  192.168.1.0/24       0.0.0.0/0            udp dpt:53
    ACCEPT     tcp  --  192.168.1.0/24       0.0.0.0/0            tcp dpt:53

**(4)** punts on blocking a couple commonly useful multicast services to the main OUTPUT chain (which means they will be ACCEPTED if there is no site policy prohibiting them): Simple Service Discovery Protocol (SSDP) and Bonjour/mDNS (ipv4: limited to the same broadcast domain, which is the local LAN segment or bridged LAN segments, eg. ethernet hub or switch, or same set of interconnected switches/hubs), unless PIM or DVMRP are used; ipv6: this is totally different).

    Chain bitmask (1 references)
    target     prot opt source
    RETURN     udp  --  0.0.0.0/0            239.255.255.250      udp dpt:1900
    RETURN     udp  --  0.0.0.0/0            224.0.0.251          udp dpt:5353

**(5)** allow all outgoing packets with a destination of the VPN gateway(s).

    Chain bitmask (1 references)
    target     prot opt source
    ACCEPT     all  --  0.0.0.0/0            199.58.81.145
    ACCEPT     all  --  0.0.0.0/0            198.252.153.28
    ACCEPT     all  --  0.0.0.0/0            5.79.86.180
    ACCEPT     all  --  0.0.0.0/0            1.209.122.29

**(6)** If debugging is enabled, then log rejected packets to syslog

    Chain bitmask (1 references)
    target     prot opt source               destination
    LOG        all  --  0.0.0.0/0            0.0.0.0/0            LOG flags 0 level 7 prefix "iptables denied:"

**(7)** reject all other ipv4 that is sent to the default device.

    Chain bitmask (1 references)
    target     prot opt source               destination
    REJECT     all  --  0.0.0.0/0            0.0.0.0/0            reject-with icmp-port-unreachable

If bitmask email is used, then there are a couple of additional firewall things done:

**(1)** first a bitmask_email chain is made to front the INPUT chain, and a bitmask_email_output is created to front the OUTPUT chain.

    Chain INPUT (policy ACCEPT)
    target     prot opt source               destination
    bitmask_email    all  --  0.0.0.0/0            0.0.0.0/0

    Chain OUTPUT (policy ACCEPT)
    target     prot opt source               destination
    bitmask_email_output    all  --  0.0.0.0/0            0.0.0.0/0

**(2)** allow access to IMAP and SMTP on the local interface, and disable access to IMAP and SMTP from the outside

    Chain bitmask_email (1 references)
    target     prot opt in     out     source               destination
    ACCEPT     tcp  --  lo     *       0.0.0.0/0            0.0.0.0/0            tcp dpt:1984
    ACCEPT     tcp  --  lo     *       0.0.0.0/0            0.0.0.0/0            tcp dpt:2013
    REJECT     tcp  --  *      *       0.0.0.0/0            0.0.0.0/0            tcp dpt:1984 reject-with icmp-port-unreachable
    REJECT     tcp  --  *      *       0.0.0.0/0            0.0.0.0/0            tcp dpt:2013 reject-with icmp-port-unreachable

**(3)** restrict access to IMAP and SMTP on the local interface to the `uid` that is running bitmask.

    Chain bitmask_email_output (1 references)
    target     prot opt in     out     source               destination
    ACCEPT     tcp  --  *      lo      0.0.0.0/0            0.0.0.0/0            owner UID match 1000 tcp dpt:1984
    ACCEPT     tcp  --  *      lo      0.0.0.0/0            0.0.0.0/0            owner UID match 1000 tcp dpt:2013
    REJECT     tcp  --  *      lo      0.0.0.0/0            0.0.0.0/0            tcp dpt:1984 reject-with icmp-port-unreachable
    REJECT     tcp  --  *      lo      0.0.0.0/0            0.0.0.0/0            tcp dpt:2013 reject-with icmp-port-unreachable

# Rule listing

VPN

    -N bitmask
    -A OUTPUT -j bitmask
    -A bitmask -d 192.168.1.0/24 -o eth0 -j ACCEPT
    -A bitmask -s 192.168.1.0/24 -o eth0 -p udp -m udp --dport 53 -j ACCEPT
    -A bitmask -s 192.168.1.0/24 -o eth0 -p tcp -m tcp --dport 53 -j ACCEPT
    -A bitmask -d 239.255.255.250/32 -o eth0 -p udp -m udp --dport 1900 -j RETURN
    -A bitmask -d 224.0.0.251/32 -o eth0 -p udp -m udp --dport 5353 -j RETURN
    -A bitmask -d 198.252.153.28/32 -o eth0 -j ACCEPT
    -A bitmask -o eth0 -j REJECT --reject-with icmp-port-unreachable

VPN NAT table

    -N bitmask
    -N bitmask_postrouting
    -A OUTPUT -j bitmask
    -A POSTROUTING -j bitmask_postrouting
    -A bitmask -d 127.0.1.1/32 -p udp -m udp --dport 53 -j ACCEPT
    -A bitmask -d 127.0.0.1/32 -p udp -m udp --dport 53 -j ACCEPT
    -A bitmask -p udp -m udp --dport 53 -j DNAT --to-destination 10.42.0.1:53
    -A bitmask -p tcp -m tcp --dport 53 -j DNAT --to-destination 10.42.0.1:53
    -A bitmask_postrouting -p udp -m udp --dport 53 -j MASQUERADE
    -A bitmask_postrouting -p tcp -m tcp --dport 53 -j MASQUERADE

Email

    -N bitmask_email
    -N bitmask_email_output
    -A INPUT -j bitmask_email
    -A OUTPUT -j bitmask_email_output
    -A bitmask_email -i lo -p tcp -m tcp --dport 1984 -j ACCEPT
    -A bitmask_email -i lo -p tcp -m tcp --dport 2013 -j ACCEPT
    -A bitmask_email -p tcp -m tcp --dport 1984 -j REJECT --reject-with icmp-port-unreachable
    -A bitmask_email -p tcp -m tcp --dport 2013 -j REJECT --reject-with icmp-port-unreachable
    -A bitmask_email_output -o lo -p tcp -m owner --uid-owner 1000 -m tcp --dport 1984 -j ACCEPT
    -A bitmask_email_output -o lo -p tcp -m owner --uid-owner 1000 -m tcp --dport 2013 -j ACCEPT
    -A bitmask_email_output -o lo -p tcp -m tcp --dport 1984 -j REJECT --reject-with icmp-port-unreachable
    -A bitmask_email_output -o lo -p tcp -m tcp --dport 2013 -j REJECT --reject-with icmp-port-unreachable

# FAQ

The bitmask firewall is *egress* only. It does nothing to protect the client device from incoming network packets.

Some people have asked how they can subvert the bitmask firewalls, for example because they want to have a large amount of data transfer not go through the gateway. For this to happen you would need to either put iptables rules before the front-loaded bitmask chain jump. You would need to do this after bitmask comes up, or bitmask will just place this again at the beginning, subverting your changes.

Some people may prefer to make bitmask firewall block egress traffic to the local network. This should be made available as an option in the future.

# Glossary

INPUT - All incoming packets are checked against the rules in this chain.

OUTPUT - All outgoing packets are checked against the rules in this chain. OUTPUT is for packets that are emitted by the host. Their destination is usually another host, but can be the same host via the loopback interface, so not all packets that go through OUTPUT are in fact outgoing.

FORWARD - All packets being sent to another computer are checked against the rules in this chain. FORWARD is for packets that are neither emitted by the host nor directed to the host. They are the packets that the host is merely routing.

# IPv6

Currently, IPv6 is mostly just blocked.

`sudo ip6tables -S`

    -N bitmask
    -A OUTPUT -j bitmask
    -A bitmask -d fe80::/64 -o eth0 -j ACCEPT
    -A bitmask -d ff05::c/128 -o eth0 -p udp -m udp --dport 1900 -j RETURN
    -A bitmask -d ff02::fb/128 -o eth0 -p udp -m udp --dport 5353 -j RETURN
    -A bitmask -p tcp -j REJECT --reject-with icmp6-port-unreachable
    -A bitmask -p udp -j REJECT --reject-with icmp6-port-unreachable

At some point, when the VPN supports IPv6, we can unblock it. Until then, it is necessary that it is blocked because it will otherwise leak traffic in the clear.