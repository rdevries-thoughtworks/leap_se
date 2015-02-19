@title = 'Release 0.6'
@author = 'Micah'
@posted_at = '2014-08-21'
@more = true
@preview = '<div style="float:left; margin-right: 8px; margin-left: 0;"><img src="/img/pages/mostimproved.jpg"></div><p>This release gets the award for most improved, with a focused on major overhauls of the Android and Linux Bitmask clients. These apps now have better security, usability, and stability. We have temporarily broken our practice of releasing all projects with the same version at the same time.</p>'

Overview
-------------------------------------

This release gets the award for most improved, with a focused on major overhauls of the Android and Linux Bitmask clients. These apps now have better security, usability, and stability. We have temporarily broken our practice of releasing all projects with the same version at the same time.

* Bitmask - Android 0.6.0
* Bitmask - Desktop 0.6.1
* LEAP Platform 0.5.3
* Webapp 0.5.3

Bitmask Android 0.6.0
-----------------------------------

This is a major release for our Android client. It contains a couple of security improvements that inaugurate a series of small but important features that will try to satisfy security minded people.

The most important security feature added in this release is the openvpn persistent tun integration with our client. Once your device establishes a vpn tunnel, and as long as you keep EIP switch ON, you'll not route any traffic outside the vpn tunnel while the vpn is being established. Other features include earlier autostart launch, prompt to log in if necessary, and man in the middle prevention.

Regarding bug fixes, we've finally removed the second notification that was annoying some users. The reason of its removal will be soon documented. Apart from that, we've also addressed the Play Store crashes, and some small UI improvements.

* Download: https://dl.bitmask.net/android
* Changelog: https://github.com/leapcode/bitmask_android/blob/develop/CHANGELOG


Bitmask Linux 0.6.1
-----------------------------------

This is the new stable version of the Desktop Client after the refactor in which we have separated frontend from backend. This separation paves the way for starting Bitmask during the boot process, and attach the current graphical client afterwards. And maybe even having cli or html5 clients in the near future, the possibilities that it opens are many!

It also allows us to finally close an annoying bug that was causing high CPU usage when using the client.

While we were at it, we gave a little face lift to the UI: the provider selection is in a more prominent place now, and some other little interface tweaks made their way into this last release. We hope you enjoy it as much as we do!

* Download: https://dl.bitmask.net/linux
* Changelog: https://raw.githubusercontent.com/leapcode/bitmask_client/master/CHANGELOG.rst

LEAP Platform 0.5.3
-----------------------------------

This release of the Platform is a minor release, stabilizing further the previous version by only fixing minor, non-disruptive issues.

* Download: signed 0.5.3 tag: https://leap.se/git/leap_platform.git
* Changelog: https://leap.se/git/leap_platform.git/shortlog/refs/tags/0.5.3
* Known issues: https://leap.se/git/leap_platform.git/blob/HEAD:/README.md


LEAP Webapp 0.5.3
-----------------------------------

This release of the webapp is also a minor bug fix release, with few changes designed to further stabilize this version. We now enable including custom gems to make customization even more powerful. We also fix corner cases during the account creation and document debugging in production.

* Download: 0.5.3 tag: https://github.com/leapcode/leap_web/archive/0.5.3.tar.gz
* Changelog: 0.5.3 is tagged for the webapp with a commit message detailing the changes: https://github.com/leapcode/leap_web/releases/tag/0.5.3
