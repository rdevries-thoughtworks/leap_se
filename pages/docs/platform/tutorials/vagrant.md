@title = 'LEAP Platform Vagrant'
@nav_title = 'Vagrant'
@summary = 'Running a local provider with Vagrant'

Use Vagrant to install the LEAP platform
========================================

There are two ways you can setup leap platform using vagrant.
If you aim at getting the platform running as quick as possible,
you should follow the second option (`2. Using the Vagrantfile provided by Leap Platform`).

1. Use the leap_cli vagrant integration
=======================================

Install `leap_cli` and LEAP Platform on your host, configure a provider from scratch and use the `leap local` commands to manage your vagrant node(s).

See [Development Environment](https://leap.se/en/docs/platform/details/development) how to use the `leap_cli` vagrant
integration and follow the [Single Node Email Tutorial](https://leap.se/en/docs/platform/tutorials/single-node-email) afterwards how
to setup a single node email server.

2. Using the Vagrantfile provided by Leap Platform
==================================================

This is by far the easiest way. It will install a single node mail server in the default
configuration with one single command.
We assume that you have [Vagrant](https://www.vagrantup.com/) installed and working for you.

Clone the platform with

    git clone --recursive -b develop https://github.com/leapcode/leap_platform.git

Start the vagrant box with

    cd leap_platform
    vagrant up

Follow the instructions how to configure your `/etc/hosts`
in order to use the provider!

You can login via ssh with the systemuser `vagrant` and the same password.

    vagrant ssh

On the host, run the tests to check if everything is working as expected:

    cd /home/vagrant/leap/configuration/
    leap test

Use the bitmask client to do an initial soledad sync
====================================================

Copy the self-signed CA certificate from the host.
The easiest way is to use the [vagrant-scp plugin](https://github.com/invernizzi/vagrant-scp):

    vagrant scp :/home/vagrant/leap/configuration/files/ca/ca.crt /tmp/example.org.ca.crt

    vagrant@node1:~/leap/configuration$ cat files/ca/ca.crt

and write it into a file, needed by the bitmask client:

    bitmask --ca-cert-file /tmp/example.org.ca.crt

On the first run, bitmask is creating a gpg keypair. This is
needed for delivering and encrypting incoming mails.


Testing email
-------------

    sudo apt install swaks
    swaks -f test22@leap.se -t test22@example.org -s example.org

check the logs:

    sudo less /var/log/mail.log
    sudo less /var/log/leap/mx.log

if an error occurs, see if the mail is still laying in the mailspool dir:

    sudo ls /var/mail/leap-mx/Maildir/new


Re-run bitmask client to sync your mail
---------------------------------------


    bitmask --ca-cert-file /tmp/example.org.ca.crt

Now, connect your favorite mail client to the imap and smtp proxy
started by the bitmask client:

    https://bitmask.net/en/help/email

Happy testing !



Using the Webapp
----------------

There are 2 users preconfigured:

. `testuser`  with pw `hallo123`
. `testadmin` with pw `hallo123`

login as `testadmin` to access the webapp with admin priviledges.




