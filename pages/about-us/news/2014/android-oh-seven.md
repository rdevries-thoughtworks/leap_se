@title = 'Bitmask Android 0.7.0'
@author = 'Parménides GV'
@posted_at = '2014-10-06'
@more = true
@preview = '<div style="float:left; margin-right: 8px; margin-left: 0;"><img src="/img/pages/android-mask.png"></div><p>We\'ve released a new version of our Android client, which improves the stability of our VPN tunnel and fixes a bunch of bugs.</p>'

We've released a new version of our Android client, which improves the stability of our VPN tunnel and fixes a bunch of bugs.

We solved a pesky problem related to memory usage. When total available memory gets very low, Bitmask would stop. To solve this problem Bitmask will now restart when neccessary.

Deep research on how AOSP (Android Open Source Project) works when an app is killed informed this solution, and the restart  should happen as quick as possible: we've measured 45 seconds in a real environment. Once implemented, this feature was suggested to the upstream project for the VPN, [ics-openvpn](https://code.google.com/ics-openvpn), and was accepted and incorporated right away (thanks Arne).

We also started to do the work needed for Bitmask to be added to F-Droid, but we're going to use a much awaited feature from F-Droid which is [almost complete](https://f-droid.org/wiki/page/Verification_Server) so stay tuned, because you'll see both F-Droid improvements from their side and Bitmask Android on an F-Droid repository really soon!

Finally, a couple of annoying bugs have been fixed: first of all, you can turn off VPN from our dashboard switch, and if that happens (or more generally, if you switch off VPN by any means), you won't see the "Blocked traffic" notification which appeared on 0.6.0.

We're beginning to collaborate with third parties, and getting more [users and feedback on the Play Store](https://play.google.com/store/apps/details?id=se.leap.bitmaskclient). As with any Libre Software project, you're more than welcomed to tell us your suggestions (use [Twitter](https://twitter.com/leapcode), [GitHub](https://github.com/leapcode/bitmask_android), [file bugs](https://leap.se/code/), or even [collaborate with us in the development itself](https://github.com/leapcode/bitmask_android#contributing).

Thanks for your attention, and if you're a user, thanks for your feedback and support!
