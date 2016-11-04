@title = 'LEAP Platform 0.9.0 Release'
@author = 'sysdevs'
@posted_at = '2016-11-03'
@more = true
@preview_image = '/img/pages/nine.jpg'

Hi all!

It is time for another release of the LEAP Platform. This time we are breaking free of the 0.8 release cycle into a new major version: 0.9.0. The new number is because of new features, instead of bug fixes, and it also marks a new stable version that we will support with critical fixes until our next major version.

The focus for this release was to clean things up, and add some new features.

The notable new features are support for managing remote virtual servers with the `leap vm` sub-command (AWS only, for now); integration with Let's Encrypt (`leap cert renew`); handy access to nagios (`leap open monitor`); and improved documentation (open docs/index.html to see). There were some other less visible improvements as well: performance improvements for couchdb, changing from httpredir mirrors, anti-spam improvements, DANE/TLSA validation, removal of the capistrano dependency, most of the leap_cli code has been moved into the platform, some logging cleanup and more tests.

The main cleanups were replacing the git submodule system with subrepos, cleaning the directory structure, setup of CI pipelines for every merge, removal of many gem dependencies for the leap cli, and an important security fix for the VPN. We also fixed plenty of bugs in the process!

Upgrading:

You should be upgrading from a 0.8 release, if you are coming from 0.7, you will need to read and follow the upgrade instructions for 0.8 before continuing to upgrade to 0.9.

You will need the new version of leap_cli:

    workstation$ sudo gem install leap_cli --version=1.9

Because 0.9 does not use submodules anymore, you must remove them before pulling
the latest leap_platform from git:

    workstation$ cd leap_platform
    workstation$ for dir in $(git submodule | awk '{print $2}'); do
    workstation$   git submodule deinit $dir
    workstation$ done
    workstation$ git pull
    workstation$ git checkout 0.9.0

Alternately, just clone a fresh leap_platform:

    workstation$ git clone https://leap.se/git/leap_platform
    workstation$ cd leap_platform
    workstation$ git checkout 0.9.0

Then, deploy:

    workstation$ cd PROVIDER_DIR
    workstation$ leap deploy

Known Issues:

* When upgrading, sometimes systemd does not report the correct state of a daemon. The daemon will be not running, but systemd thinks it is. The symptom of this is that a deploy will succeed but `leap test` will fail. To fix, you can run `systemctl stop DAEMON` and then `systemctl start DAEMON` on the affected host (systemctl restart seems to work less reliably).

* Includes:
  * leap_web: 0.8
  * nickserver: 0.8
  * couchdb: 1.6.0
  * leap-mx: 0.8.1
  * soledad-server: 0.8.0

* Commits: https://leap.se/git/leap_platform.git/shortlog/refs/tags/0.9
* Issues fixed: https://leap.se/code/versions/195
