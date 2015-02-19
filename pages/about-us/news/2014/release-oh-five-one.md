@title = 'Release 0.5.1'
@author = 'Micah'
@posted_at = '2014-05-22'
@more = true
@preview = '<div style="float:left; margin: 8px; margin-left: 0;"><img src="/img/pages/sand-bucket.jpg"></div><p>We are happy to announce the 0.5.1 LEAP release, code named "los trecesemanas" or "lil less leaky". This rapid round of development focused primarily on getting our Encrypted Internet Proxy (VPN) system secured against data leakage, as well as the continued refactor of the soon to be released encrypted email service.</p>'

We are happy to announce the 0.5.1 LEAP release, code named "los trecesemanas" or "lil less leaky". This rapid round of development focused primarily on getting our Encrypted Internet Proxy (VPN) system secured against data leakage, as well as the continued refactor of the soon to be released encrypted email service.

Various development details for the client, platform and the webapp are below.

Platform
========

The platform had a number of minor improvements, mostly the work is EIP related: deployment improvements make openvpn service fragments be fully created before the service is deployed. We now block EIP originated DNS traffic at the OpenVPN gateway. We now install openvpn 2.3 from wheezy backports, and set the ipv6 configuration options to force client ipv6 traffic through the gateway, and then reject any outgoing ipv6 packets. Additionally, script-security is set to '1' and tcp-nodelay is configured.

There were also few other minor improvements in other areas: the initial firewall will allow port 22 by default, and it triggers better. There were nagios check improvements to eliminate duplicates. Service levels were added to the webapp config; known issues are now documented in the git repository; a simple shorewall whitebox test was added; rsyslog and unbound are now pulled from wheezy-backports. Stunnel refreshing will happen more reliably. Tor nicknames will get set automatically, with a default, and the tor family variable will be filled out correctly. The resolv.conf is fixed on virtualbox. Now we can put the webapp on a subdomain and we have support for environmentally scoped services and tags, when using latest leap_cli.

Download:

* There is a signed 0.5.1 tag: https://leap.se/git/leap_platform

Changelog:

* https://leap.se/git/leap_platform.git/shortlog/refs/tags/0.5.1

Known issues:

* https://leap.se/git/leap_platform.git/blob/071547967cc00acf18bf68b78e350131017852b9:/README.md

Webapp
==================

Webapp development was focused on getting it ready for the beta launch. We enhanced the API with an endpoint to query for the services available when logged in and to notify users via the client. The directory and engine structure has been cleaned up. Documentation now lives on leap.se/docs. Lot's of bugs have been found and fixed during QA and we ensure the availability with nagios tests.

Changelog:

* https://github.com/leapcode/leap_web/releases/tag/0.5.1

Android
==================

Android version is running slighly ahead fo the rest! We released 0.5.1 three weeks ago and have made public our 0.5.2 release candidate. 0.5.1 and 0.5.2rc improvements include:

1. Autostart - If you have EIP on and shutdown your phone, Bitmask will autostart EIP once the phone is running again.
2. Gradle support - This only matters to developers, and they'll know what this means, so no more words
3. Signup support - You can register a new account with a LEAP provider from the android client.

Autostart still has some glitches due to some problems with ics-openvpn. Next weeks we'll address these issues by cleaning and updating our ics-openvpn codebase. So hold your breath for the next 3 weeks, you'll hopefully see a very good 0.5.2 (or even 0.6!) release.

Download:

* https://play.google.com/store/apps/details?id=se.leap.bitmaskclient
* https://downloads.leap.se/client/android/Bitmask-Android-0.5.2-RC1.apk

Changelog:

* https://raw.githubusercontent.com/leapcode/bitmask_android/master/CHANGELOG

Client
==================

The client focus was towards fixing a security problem that exists in every VPN client to this date, which is: if VPN fails in any way, your traffic gets leaked out of the secure network.

We leverage the Linux firewall to block all traffic outside of the computer except for the VPN gateways. So even if OpenVPN crashes or the client wrongly says you're going through EIP, you won't be leaking traffic when you are not expecting it.

The same approach will be expanded to other platforms in the near future.

Known Issues: Firewall is torn down during restarts #5687. This should be fixed in the early 0.5.2 rc.

Download:

* https://dl.bitmask.net

Changelog: leap.bitmask

* https://raw.githubusercontent.com/leapcode/bitmask_client/develop/CHANGELOG.rst

Changelog: leap.soledad

* https://raw.githubusercontent.com/leapcode/soledad/develop/CHANGELOG

