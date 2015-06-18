@title = 'Bitmask Android v0.9.4'
@author = 'Parmegv'
@posted_at = '2015-06-18'
@more = true
@preview_image = '/img/pages/android-mask.png'
@preview = %[The "fabbutton" release is here with big changes to the UI, updated dependencies, a dialog management bug fix, ics-openvpn, Spanish localization, and more!]

A new Bitmask forged in the fires of the Circumvention Technology Conference is ready for beta use and testing on Android. We are happy to announce a solid set of UI and functional improvements to the app. We conducted user tests with OpenITP during the Circumvention Tech Conference in Valencia, Spain and have improved the application based on the excellent feedback. Special thanks to Gus Andrews and OpenITP. New in this release:

* Optimized layout on various devices, so that UI remains consistent across sizes, screen resolutions.
* Localized the app to Spanish, and simplified the login/logout feedback so that localization can be polished.
* Improved wording, both in Spanish and in English.
* Removed the progress bars that caused confusion in some states such as "Waiting for connectivity".
* Removed the on/off button that was not clear enough (some users experimented problems with it during connections, staying "on" while the VPN was "off",) and put an icon with a progress indicator around it.
* Automatically show the log window when an error occurs, since some users weren't able to know why Bitmask had failed and they didn't think of opening the log by themselves.
* Users discovered previously fixed bugs. We enhanced test coverage to ensure fixed bugs stay fixed.
* Aborting the establishment of a new VPN connection didn't work properly, and some users were confused because they wanted to cancel an establishing connection, but the UI indicators and the feature didnt funtion consistantly. This has been improved, and Bitmaks is now able to detect the real status of the VPN connection much better.

Release 0.9.4 links:

* Changelog, https://github.com/leapcode/bitmask_android/blob/master/CHANGELOG
* Source Code: https://github.com/leapcode/bitmask_android/releases/tag/0.9.4
* Google Play: https://play.google.com/store/apps/details?id=se.leap.bitmaskclient
* APK Download: https://dl.bitmask.net/client/android/Bitmask-Android-0.9.4.apk
