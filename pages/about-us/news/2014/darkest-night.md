@title = 'New releases for a new year'
@author = 'Staff'
@posted_at = '2014-12-23'
@more = true
@preview = '<div style="float:left; margin-right: 8px; margin-left: 0;"><img src="/img/pages/winter-solstice-at-stonehenge.jpg"></div><p>LEAP is happy to celebrate the days getting longer with shiny new releases of the LEAP platform and Bitmask client for Linux and Android. We resolved over 160 issues for the platform release alone!<p>'

LEAP is happy to celebrate the days getting longer with shiny new releases of the LEAP platform and Bitmask client for Linux and Android.

Platform 0.6.0
--------------

With over 160 issues resolved, the latest platform is a fine tuned, easy to deploy, self monitoring machine. We are real happy with its current state and are looking forward to pushing more frequent releases in the coming months.

Whats New: single node deployment; platform customization; couch flexibility; stunnel rework; new debian repository structure; dependency pinning; leap_cli modularization; improved cert generation; monitoring improvements such as per-environment tooling and notifications; tor hidden service support; switch away from NIST curve and ensure TLSv1 is used; tests made significantly more robust; add support for webapp deployment to a subdomain; many, many bugfixes and stability improvements

* Download 0.6.0 signed tag: https://leap.se/git/leap_platform.git
* Changelog: https://leap.se/git/leap_platform.git/shortlog/refs/tags/0.6.0
* Known issues: https://leap.se/en/docs/platform/troubleshooting/known-issues


Bitmask 0.7.0
-------------

The LEAP team is pleased to announce the immediate availability of Bitmask 0.7.0 codename "One window to rule them all". We are introducing automatic secure updates for the Bitmask application, making use of a spell called [The Update Framework](http://theupdateframework.com/), aka TUF if you're on friendly terms. Based on your feedback, we are also introducing a sleek new settings panel. As usual, we have also crushed a few bugs along the way.

For the users of the Linux Bundles, this is the first Bitmask Desktop client release that brings the ability to self-update. This means that you will be able to easily up to date to the latest version. On startup, the app will look for updates, and let you known when a new release is ready and give you a one-click access to the update. If you are using your package manager, you will still have to use the traditional methods to get updates (in ubuntu/Debian, that’s apt-get update &&  apt-get upgrade).

Enjoy it while it is hot!

* Download: https://dl.bitmask.net/linux
* Download 0.7.0 signed tag: https://leap.se/git/bitmask_client.git
* Changelog: https://raw.githubusercontent.com/leapcode/bitmask_client/master/CHANGELOG.rst
* Known issues: https://leap.se/en/docs/client/known-issues
* Compatibility notes: Bitmask 0.7.0 is not compatible with platform versions older than 0.6.0

Bitmask Android 0.8.2
-----------------------------

Lollipop is here, and Bitmask Android has been visually and internally updated to give the best experience to date for both early Android 5.0 adopters and usual Android 4 users.

Two new providers have been added to our preseeded list, and a lot of bugs have been fixed. This release will hopefully be the best one yet, both in terms of usability and stability.

Stay tuned, because 0.9.0 will arrive soon with interesting new VPN features!

Changelog: https://github.com/leapcode/bitmask_android/blob/master/CHANGELOG
