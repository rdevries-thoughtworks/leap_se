@title = 'Bitmask Desktop v0.8.1'
@author = 'Ivan'
@posted_at = '2015-03-07'
@more = true
@preview = '<div style="float:left; margin-right: 8px; margin-left: 0;"><img src="/img/pages/bitmask.png"></div><p>Bitmask for Linux 0.8.1 has been released. This release includes a couple of important bugfixes and a secure ZMQ fallback for distros that does not have CurveZMQ available.</p>'

Bitmask for Linux 0.8.1 has been released.

This release includes a couple of important bugfixes and a secure ZMQ
fallback for distros that does not have CurveZMQ available.

Upgrading:

* From bundle: if you are running bundle version 0.7 or new then Bitmask should update automatically.
* From package: if you have added deb.bitmask.net to your sources.list, then Bitmask should update automatically (make sure it is not commented out).

If you have a bundle version older than 0.7, please reinstall Bitmask.

This version includes all the goods that we shipped on previous ones like  the Encrypted Internet service (with leak blocker) and Secure Updates.

* Install: https://bitmask.net/en/install
* Source: https://leap.se/git/bitmask_client.git
* Changelog: https://github.com/leapcode/bitmask_client/blob/0.8.1/CHANGELOG.rst
* Known issues: https://leap.se/en/docs/client/known-issues
* Compatibility notes: Bitmask 0.8.1 is not compatible with platform versions older than 0.6.0