@title = 'LEAP Platform 0.8.2 Release'
@author = 'sysdevs'
@posted_at = '2016-09-01'
@more = true
@preview_image = '/img/pages/eight.jpg'

We are releasing Platform 0.8.2 today. This is release fixes a potential security issue where VPN clients are able to communicate with other connected VPN clients. It is just a minor release to fix bugs, security issues and further stabilize the 0.8.1 release. This release has only a few, but important, changes. By design it does not contain any new features. Please see below for requirements and details for upgrading.

UPGRADING: It is tricky to upgrade the OS and migrate the database. Please follow our [[upgrade tutorial => upgrade-0-8]].

WARNING: failure to migrate data from BigCouch to CouchDB will cause all user accounts to get destroyed.

Changes:

* couchdb errors on specific users
* fix mail sending domain
* fix Tor hidden services for static sites
* fix Tor hidden service hostname
* fix for tor not being restarted when the key or HS hostname is changed
* fix leap add-user when gem is missing
* fix for leap cert csr not creating cert files
* fix for bind9 being greedy and taking over unbound's role
* fix some unnecessary puppet messages
* fix mail delivery/clamav tests
* fix static host apache virtual host configuration
* fix for DKIM keys not getting deployed
* fix for VPN allowing network access to other connected clients
* remove unnecessary nagios soledad check
* fix missing auth.log
* fix duplicate syslog messages
* extend local check_mk checks
* use nodelay socket option for couchdb httpd server

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
