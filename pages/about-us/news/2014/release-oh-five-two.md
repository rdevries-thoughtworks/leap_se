@title = 'Release 0.5.2'
@author = 'Micah'
@posted_at = '2014-06-22'
@more = true
@preview = '<div style="float:left; margin-right: 8px; margin-left: 0;"><img src="/img/pages/toolbox.jpg"></div><p>Along with ongoing bug fixes and stability enhancements, the 0.5.2 release of the bitmask client focused on improving VPN security features added in the prior release. In Android development, we are laying the groundwork for better coordination with ics-openvpn which will improve stability and user experience. We plan to launch our beta VPN service in the coming weeks. All of our code that is released is now signed by the LEAP code signing key (key ID 0x1E34A1828E207901, Fingerprint 1E45 3B2C E87B EE2F 7DFE  9966 1E34 A182 8E20 7901).</p>'

Overview
---------------

Along with ongoing bug fixes and stability enhancements, the 0.5.2 release of the bitmask client focused on improving VPN security features added in the prior release. In Android development, we are laying the groundwork for better coordination with ics-openvpn which will improve stability and user experience. We plan to launch our beta VPN service in the coming weeks. Stay tuned!

In addition to the 0.5.2 releases detailed below, we have now all of our code that is released is signed by the LEAP code signing key (key ID 0x1E34A1828E207901, Fingerprint 1E45 3B2C E87B EE2F 7DFE  9966 1E34 A182 8E20 7901).

Client
---------------

An overall improvement in user experience for the fail close security feature was the main focus. We improved the firewall handling on Linux for failing close when the VPN doesn't work as expected.

Changelogs:

* leap.bitmask 0.5.2 - https://github.com/leapcode/bitmask_client/blob/develop/CHANGELOG.rst
* leap.common 0.3.8 - https://github.com/leapcode/leap_pycommon/blob/develop/CHANGELOG

Platform
---------------

This release of the platform has a few minor bug fixes, and a few new features.

It is now possible to run the webapp and mx on the same host; it is now possible to change the sshd port for nodes; static sites now support rack applications and custom apache configurations and /provider.json can now be served from the static site; the templatewlv function was added enabling passing local variables to templates.

Various minor code cleanups happened, removing redundant or unused classes and variables, consolidating duplicated pieces and fixing the non-functioning inclusion of the sshd class. Some improved documentation and a fix for unbound configs in the unbound.conf.d directory.

* Download:
There is a signed 0.5.2 tag: https://leap.se/git/leap_platform.git
* Changelog:
https://leap.se/git/leap_platform.git/shortlog/refs/tags/0.5.2
* Known issues:
https://leap.se/git/leap_platform.git/blob/071547967cc00acf18bf68b78e350131017852b9:/README.md

Webapp
---------------

We continue polishing the webapp for beta launch and integration with existing services. We prevent users from seeing the tickets of other users and hash our tokens to prevent timing attacks. We ease the integration for providers with existing user bases and use smtp certs to be able to kick out spammers. The UI has been polished with customized error pages and improved i18n.

0.5.2 is tagged for the webapp with a commit message detailing the changes: https://github.com/leapcode/leap_web/releases/tag/0.5.2


Android
---------------

With this version we begin a strong effort to maintain a sane upstream relationship with our base project, ics-openvpn. This is an important step for the stablility and and ease of use for our EIP client, and we're excited about what it means for our development process. We are polishing our patches and will be proposing these to ics-openvpn after our next releaes.

Also, we have added signup support, enabling you to do so from the login button and from a menu button.

Changelog: https://github.com/leapcode/bitmask_android/blob/0.5.2/CHANGELOG



Soledad
--------------

Focus for this release was on soledad sync stability and speed. This version of Soledad features a sync process which performs one HTTP request for each document sent to or received by the server. The sync process can be interrupted and also reports its status. Two minor bugs have been squashed: avoiding a bigcouch multipart-put bug and authenticating in constant-time to avoid time attacks against the auth scheme.

leap.soledad 0.5.2 - https://github.com/leapcode/soledad/blob/develop/CHANGELOG
