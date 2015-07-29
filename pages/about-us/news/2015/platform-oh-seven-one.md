@title = "Platform release 0.7.1"
@author = "Micah"
@posted_at = "2015-07-29"
@more = true
@preview_image = "/img/pages/seven.jpg"
@preview = %(The new LEAP Platform 0.7.1 is now available. The last 0.7 release included many major changes. This release, on the other hand, mostly contains bugfixes and changes requested by the new service providers who are learning to adopt the platform. Also, the web application now works in a dozen languages.)

The new LEAP Platform 0.7.1 is now available. The last 0.7 release included many major changes. This release, on the other hand, mostly contains bugfixes and minor changes requested by the new service providers who are learning to adopt the platform. Also, the web application now works in a dozen languages.

The next big release will be 0.8, and will focus exclusively on improvement to the email system: better Spam prevention, better abuse prevention, better DNS, email bug fixes, etc.

* Download 0.7.1 signed tag: https://leap.se/git/leap_platform.git
* Changelog: https://leap.se/git/leap_platform.git/shortlog/refs/tags/0.7.1
* Issues fixed: https://leap.se/code/versions/159
* Known issues: https://leap.se/en/docs/platform/troubleshooting/known-issues

Compatibility:

* Requires leap_cli version >= 1.7.4
* Requires bitmask client version >= 0.7
* Includes:
** leap_mx 0.7.0
** tapicero 0.7
** leap_web 0.7.1
** soledad 0.7

Upgrading:

   gem install leap_cli --version 1.7.4
   cd leap_platform; git pull; git checkout 0.7.1
   leap deploy
   leap test