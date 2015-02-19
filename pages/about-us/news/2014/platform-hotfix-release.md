@title = 'Platform HotFix Release 0.5.4.1'
@author = 'Micah'
@posted_at = '2014-08-28'
@more = true
@preview = '<div style="float:left; margin: 8px; margin-left: 0;"><img src="/img/pages/chillies.jpg"></div><p>This Platform release is a hotfix release, resolving a couple issues that came up in the previous release. It fixes tapicero dependency ordering so it will start more reliably (#6004); resolves the /etc/hosts ordering to properly construct the FQDN (#5835); and finally a fix for the logging problem (#6020)</p>'

This Platform release is a hotfix release, resolving a couple issues that came up in the previous release. It fixes tapicero dependency ordering so it will start more reliably (#6004); resolves the /etc/hosts ordering to properly construct the FQDN (#5835); and finally a fix for the logging problem (#6020)

There's ongoing work to make leap_platform run all services on one single node. However, this is not possible in this release.

* Download: signed 0.5.4.1 tag: https://leap.se/git/leap_platform.git
* Changelog: https://leap.se/git/leap_platform.git/shortlog/refs/tags/0.5.4.1
* Known issues: https://leap.se/git/leap_platform.git/blob/HEAD:/README.md
