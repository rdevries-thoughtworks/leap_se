@title = 'LEAP Platform 0.8.1 Release'
@author = 'sysdevs'
@posted_at = '2016-06-16'
@more = true
@preview_image = '/img/pages/eight.jpg'

Today we release the Platform 0.8.1, a minor release to fix some issues that came up from the previous major (0.8.0) release. This release has only a few, but important, changes. By design it does not contain any new features. Please see below for requirements and details for upgrading.

UPGRADING: It is tricky to upgrade the OS and migrate the database. Please follow our [[upgrade tutorial => upgrade-0-8]].

WARNING: failure to migrate data from BigCouch to CouchDB will cause all user accounts to get destroyed.

Changes:

* Disabling unnecessary Trace functionality in the webserver
* Fixing opendkim socket location and availability
* Making stunnel more robust to failures on deploy
* Ensuring that bundler is run when needed for static sites
* Fix a typo that kept common.ENV.json from being loaded
* Remove a clamav configuration option that was obsolete 
* Ensure soledad has access to x509 variables
* Disable puppet-agent daemon from running
* Reduce check-mk timeouts

Compatibility:

* Now, soledad and couchdb must be on the same node.
* Requires Debian Jessie. Wheezy is no longer supported.
* Requires CouchDB, BigCouch is no longer supported.
* Requires leap_cli version 1.8
* Requires bitmask client version >= 0.9
* Includes:
  * leap_mx 0.8
  * webapp 0.8
  * soledad 0.8


Links:

* Commits: https://leap.se/git/leap_platform.git/shortlog/refs/tags/0.8.1
* Issues fixed: https://leap.se/code/versions/209
