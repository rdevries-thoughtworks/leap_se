@title = 'LEAP Platform 0.8 Release'
@author = 'sysdevs'
@posted_at = '2016-05-16'
@more = true
@preview_image = '/img/pages/eight.jpg'

We are happy to announce the release of Platform 0.8! Although this release focuses specifically on email support, we also took care of nearly 200 other issues that were needed, including upgrading from Debian Wheezy to Jessie, BigCouch to CouchDB, and many other features and bug fixes. This is a biggest update yet, with 412 commits.

UPGRADING: It is tricky to upgrade the OS and migrate the database. Please follow our [[upgrade tutorial => upgrade-0-8]].

WARNING: failure to migrate data from BigCouch to CouchDB will cause all user accounts to get destroyed.

New features:

* It is possible to require invite codes for new users signing up.
* Tapicero has been removed. Now user storage databases are created as needed by soledad, and deleted eventually when no longer needed.
* Admins can now suspect/enable users and block/enable their ability to send and receive email.
* Support for SPF and DKIM in DNS.

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

* Commits: https://leap.se/git/leap_platform.git/shortlog/refs/tags/0.8
* Issues fixed: https://leap.se/code/versions/189
