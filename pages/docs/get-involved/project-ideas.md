@title = "Project Ideas"
@summary = "Ideas for discrete, unclaimed development projects that would greatly benefit the LEAP ecosystem."

Interested in helping with LEAP? Not sure where to dive in? This list of project ideas is here to help.

These are discrete projects that would really be a great benefit to the LEAP development effort, but are separate enough that you can dive right in without stepping on anyone's toes.

If you are interested [contact us on IRC or the mailing list](communication). We will put you in touch with the contact listed under each project.

If you have your own ideas for projects, we would love to hear about it!

Bitmask Client Application
=======================================

Email
---------------------------------------

### Apple Mail plugin

We have an extension for Thunderbird to autoconfigure for use with Bitmask. It would be great to do the same thing for Apple Mail. [Some tips to get started](http://blog.adamnash.com/2007/09/17/getting-ready-to-write-an-apple-mailapp-plug-in-for-mac-os-x/) and a "links to many existing Mail.app plugins"[http://www.tikouka.net/mailapp/]

* Contact: drebs
* Priority: Low
* Difficulty: Low
* Skills: MacOS programming, Objective-C or Python (maybe other languages too?)

### Microsoft Outlook plugin

We have an extension for Thunderbird to autoconfigure for use with Bitmask. It would be great to do the same thing for Outlook.

* Contact: drebs
* Priority: Low
* Difficulty: Low
* Skills: Windows programming

Soledad Client
---------------------------

### Soledad port

[[Soledad]] is our synchronized, client-encrypted, searchable database. It is written in Python, based on the Python implementation of U1DB (U1DB has similar features to Soledad, but has no encryption). There is also a C version of U1DB called libu1db. This project would be incrementally replace portions of the Python implementation with a version that can be compiled in order to make binding available on Android and iOS.

* Contact: drebs
* Difficulty: Hard
* Priority: High
* Skills: C/C++, using crypto libraries correctly, test driven development.

Linux
---------------------------

### Package application for non-Debian linux flavors

The Bitmask client application is entirely ported to Debian, with every dependency library now submitted to unstable. However, many of these packages are not in other flavors of linux, including RedHat/Fedora, SUSE, Arch, Gentoo.

* Contact: kali, micah, ivan
* Difficulty: Medium
* Skills: Linux packaging

### Package application for BSD

The Bitmask client application is entirely ported to Debian, with every dependency library now submitted to unstable. However, many of these packages are not in *BSD.

* Contact: ivan
* Difficulty: Medium
* Skills: BSD packaging

Mac OS
-------------------------

### Proper privileged execution on Mac

We are currently running openvpn through cocoasudo to run OpenVPN with admin privs, we should not depend on a third party app and handle that ourselves. The proper way to do this is with [Service Management framework](https://developer.apple.com/library/mac/#samplecode/SMJobBless/Introduction/Intro.html).

* Contact: ivan, kali
* Difficulty: Medium
* Skills: Mac programming

### Prevent DNS leakage on Mac OS

Currently, we block DNS leakage on the OpenVPN gateway. This works, but it would be better to do this on the client. The problem is there are a lot of weird edge cases that can lead to DNS leakage. See [dnsleaktest.com](http://www.dnsleaktest.com/) for more information.

* Contact: kali, ivan
* Difficulty: Medium
* Skills: Mac programming

Windows
-------------------------------

### Code signing on Windows

The bundle needs to be a proper signed application in order to make it safer and more usable when we need administrative privileges to run things like OpenVPN.

* Contact: ivan
* Difficulty: Easy to medium
* Skills: Windows programming

### Proper privileged execution on Windows

Right now we are building OpenVPN with a manifest so that it's run as Administrator. Perhaps it would be better to handle this with User Account Control.

* Contact: ivan, kali
* Difficulty: Medium
* Skills: Windows programming

### Prevent DNS leakage on Windows

Currently, we block DNS leakage on the OpenVPN gateway. This works, but it would be better to do this on the client. The problem is there are a lot of weird edge cases that can lead to DNS leakage. See [dnsleaktest.com](http://www.dnsleaktest.com/) for more information.

* Contact: kali, ivan
* Difficulty: Medium
* Skills: Windows programming

### Add Windows support for Soledad and all the different bundle components

We dropped Windows support because we couldn't keep up with all the platforms, Windows support should be re-added, which means making sure that the gpg modules, Soledad and all the other components are written in a proper multiplatform manner.

* Contact: ivan, drebs
* Difficulty: Easy to Medium
* Skills: Windows programming, Python

### Create proper Windows installer for the bundle

We are aiming to distributing bundles with everything needed in them, but an amount of users will want a proper Windows installer and we should provide one.

* Contact: ivan, kali
* Difficulty: Medium
* Skills: Windows programming

### Document how to build everything with Visual Studio Express

All the python modules tend to be built with migw32. The current Windows bundle is completely built with migw32 for this reason. Proper Windows support means using Visual Studio (and in our case, the Express edition, unless the proper licenses are bought).

* Contact: ivan
* Difficuty: Medium to Hard
* Skills: Windows programming

### Support Windows 64bits

We have support for Windows 32bits, 64bits seems to be able to use that, except for the TAP driver for OpenVPN. So this task is either really easy because it's a matter of calling the installer in a certain way or really hard because it involves low level driver handling or something like that.

* Contact: ivan
* Difficulty: Either hard or really easy.
* Skills: Windows programming

Android
----------------------------------------------

### Dynamic OpenVPN configuration

Currently the Android app chooses which VPN gateway to connect to based on the least difference of timezones and establishes a configuration for connecting to it by a biased selection of options (port, proto, etc) from the set declared by the provider through the API.  For cases where a gateway is unavailable or a network is restricting traffic that our configuration matches (e.g. UDP out to port 443), being able to attempt different configurations or gateways would help finding a configuration that worked.

* Contact: parmegv
* Difficulty: Easy
* Skills: Android programming

### Ensure OpenVPN fails closed

For enhanced security, we would like the VPN on android to have the option of blocking all network traffic if the VPN dies or when it has not yet established a connection. Network traffic would be restored when the user manually turns off the VPN or the VPN connection is restored. Currently, there is no direct way to do this with Android, but we have a few ideas for tackling this problem.

* Contact: parmegv
* Difficulty: Easy
* Skills: Android programming

## Improved UX

There are several areas where the user experience could be improved, particulary where it comes to our attempts to block unencrypted traffic.

* Contact: parmegv
* Priority: Medium
* Difficulty: Depends
* Skills: Android programming

Installer and Build Process
----------------------------------------------

### Reproducible builds with Gitian for bundles

We rely on a group of binary components in our bundles, these include libraries like boost, Qt, PySide, pycryptopp among many others. All these should be built in a reproducible way in order to be able to sign the bundles from many points without the need to actually having to send the bundle from the main place it gets built to the rest of the signers. This will also allow a better integration with our automatic updates infrastructure.

* Contact: ivan
* Difficulty: Medium to hard

### Automatic dependency collector for bundle creation

The bundles are now used as a template for new versions, the first bundle was basically built by hand, adding one dependency after the other until it all worked. We would like to automate this process completely, since new dependencies tend to be added at certain points. One possibility would be to use PyInstaller dependency recollection code, another would be to use some of Python's module introspection to recursively collect dependencies.

* Contact: ivan, kali
* Difficulty: Medium to hard

### Lightweight network installer

The bundles are big. It would be great if we could reduce its size, but that's not always possible when you are providing so many different things in one application. One way to work around this would be to have a really tiny application that runs Thandy, has the proper certificates and has a tiny lightweight UI so that the user can install the bundle's packages one by one and even pick parts that the user might not want. Just want to run Email? Then there's no need to download OpenVPN and all the chat and file sync code.

* Contact: ivan
* Difficulty: Medium
* Skills: C/C++, Python

New Services
----------------------------------

### Password keeper

There are multiple password keepers that exist today, but they don't necessarily have a way to sync your passwords from device to device. Building a Soledad backed password keeper would solve all these problems implicitly, it's only a matter of UI and random password generation.

* Contact: drebs, ivan, elijah
* Priority: Low
* Difficulty: Easy to medium
* Skills: Python

### Notepad app

This idea is basically a simple note pad application that saves all its notes as Soledad documents and syncs them securely against a Soledad server.

* Contact: ivan, kali, drebs
* Priority: Low
* Difficulty: Easy to medium
* Skills: Python

Miscellaneous
-------------------------------

### Token-based user registration

The idea is to allow or require tokens in the new user signup process. These tokens might allow to claim a particular username, give you a credit when you sign up, allow you to sign up, etc.

* Dependency: token-based signup in webapp API.
* Contact: elijah, ivan
* Difficulty: Easy
* Skills: Python

### General QA

One thing that we really need is a team of people that is constantly updating their versions of the code and testing the new additions. Basic knowledge of Git would be needed, and some really basic Python.

* Contact: mcnair, elijah, ivan
* Difficulty: Easy to medium, depending on the QA team that is managed.

### Translations

Do you speak a language that's not English? Great! We can use your help! We are always looking for translators for every language possible.

* Contact: ivan, kali, ivan
* Difficulty: Easy

### Support for OpenPGP smart cards

A really nice piece of hardware is OpenPGP smart cards. What would be needed is a way to save the generated key in the smart card instead of in Soledad (or both, should be configurable enough) and then migrate the regular OpenPGP workflow to support these change.

* Contact: ivan, drebs
* Difficulty: Medium

### Device blessing

Add the option to require a one-time code in order to allow an additional device to be synchronized with your account.

* Contact: elijah
* Difficulty: Hard
* Skills: Python

### Push notifications from the server

There are situations where the service provider you are using through the bitmask client might want to notify some event to all its users. May be some downtime, or any other problems or situations. There should be an easy way to push such notifications to the client.

* Contact: ivan, elijah
* Difficulty: Easy
* Skills: Python

### Quick wipe of all data

Some users might be in situations where being caught with software like OpenVPN is illegal or basically just problematic. There should be a quick way to wipe the existence of the whole bundle and your identity from provider.

* Contact: ivan, kali, ivan, elijah
* Difficulty: Easy
* Skills: Python


LEAP Platform
===========================

Soledad Server
---------------------------

### Add support for quota

Soledad server only handles authentication and basic interaction for sync, it would be good to have a way to limit the quota each user has to use and enforce it through the server.

* Contact: ivan, drebs
* Priority: Medium
* Difficulty: Medium
* Skills: Python

### Add support for easier soledad server deployment

Currently Soledad relies on a fairly complex CouchDB setup. It can be deployed with just one CouchDB instance, but may be if you are just using one instance you might be good enough with SQLite or other easy to setup storage methods. The same applies to authentication, may be you want a handful of users to be able to use your Soledad sever, in which case something like certificate client authentication might be enough. So it would be good to support these non-scalable options for deploying a Soledad server.

* Contact: ivan, drebs
* Priority: Low
* Difficulty: Medium
* Skills: Python

### A soledad management tool

Bootstrapping Soledad and being able to sync with it is not a necessarily easy task, you need to take care of auth and other values like server, port, user id. Having an easy to use command line interface application that can interact with Soledad would ease testing both on the client as on the server.

* Contact: ivan, drebs
* Priority: Low
* Difficulty: Easy
* SKills: Python

### Federated Soledad

Currently, each user's Soledad database is their own and no one else ever has access. It would be mighty useful to allow two or more users to share a Solidad database. This would allow us to use Soledad for a shared calendar, for example.

* Contact: drebs, elijah
* Difficult: Hard
* Skills: Python

DNS
--------------------------------

### Add DNSSEC entries to DNS zone file

We should add commands to the leap command line tool to make it easy to generate KSK and ZSK, and sign DNS entries.

* Contact: elijah, micah, varac
* Difficulty: Easy
* Skills: Ruby

### Add DANE entries to DNS zone file

Every node one or more server certificates. We should publish these using DANE.

* Contact: elijah, micah, varac
* Difficulty: Easy

### Add DKIM entries to DNS zone file

We need to generate and publish [DKIM](https://en.wikipedia.org/wiki/DKIM) keys.

* Contact: elijah, micah, varac
* Difficulty: Easy

OpenVPN
-----------------------------------

### OpenVPN with ECC PFS support

Currently, OpenVPN gets configured to use a non-ECC DH cipher with perfect forward secrecy, but it would be nice to get it working with an Elliptical Curve Cipher. This greatly reduces the CPU load of the OpenVPN gateway.

* Contact: elijah, varac
* Priority: Low
* Difficulty: Low
* Skills: OpenVPN, X.509

Email
--------------------------

### Mailing list support

Managing an encrypted mailing list is too difficult for most users. Even worse, existing solutions store a private key for the list on the server. It would be very useful to have a simple, end-to-end encrypted mailing list system that anyone could use.

Our idea is a simple API that allows the client to query the subscriber list and set a new subscriber list. This command would include the addresses that should be subscribed to the list, and the full fingerprint of the key to use for each address. So long as this command was signed by a subscriber's private key, the list server accepts the new subscriber list. As an next iteration, the software could support the ability to designate that only "admins" have this ability. The client application would then include a simple form for modifying the list of subscribers. There would be no archives and no web interface.

Another possibility is something like, [PSELS](http://www.ncsa.illinois.edu/people/hkhurana/ICICS.pdf). PSELS uses OpenPGP in a novel way to achieve proxy re-encryption, allowing for a mailing list in which the server does not ever have access to messages in cleartext, but subscribers don't need to encrypt each message to the public key of all subscribers. However, the setup is incredibly complex, and requires special keys.

* Contact: elijah
* Priority: Medium
* Difficulty: Hard
* Skills: Cryptography, Python


LEAP Webapp
============================

### Add support for bitcoin payments to the billing module

The webapp has a payment infrastructure setup (Braintree), but it only supports credit card and bank wire payments. The webapp should be extended to also accept payments from bitcoin.

* Contact: azul, elijah, jessi
* Difficulty: Easy

### Add support for newsletter

Sometimes simple push notifications aren't enough, you may want to mail a newsletter to your users or more descriptive notifications, it should be possible for an administrator of a provider to use the webapp to quickly send mail to all its users.

* Contact: jessi, azul, elijah
* Difficulty: Easy

### Add support for quota

Description: Once the Soledad server quota enforcement code is in place, it would be good to have the ability to configure the quota for a user and check the user's quota via the webapp.

* Dependency: Soledad server quota enforcement.
* Contact: azul, elijah
* Difficulty: Easy
* Skills: Ruby

### Add support for token-based user registration

The idea is to allow or require tokens in the signup process. These tokens might allow to claim a particular username, give you a credit when you sign up, allow you to sign up, etc.

* Contact: azul, jessi, elijah
* Difficulty: Easy
* Skills: Ruby and Javascript

### Add a status system

Having a simple way for users to be able to visit the website to see if there are any system problems they should be aware of would be very useful. Exposing to the administrators a way to add a system status notification, and set a critical priority level and then the newest message would be displayed on the top of a status page, using different colors for the severity levels. 

* Contact: guido, azul, elijah, micah
* Difficulty: Easy
* Skills: Rails

### Internal knowledge base

When a user reports a problem, suggest related help pages that could solve their problem. Many of the more useful help ticket systems out there will do this, its a great way to cut down on requests for help that are handled by the documentation. If the suggested help pages could be additionally triggered by some tags, enabling the provider to hint the suggestions based on their experiences would be very helpful.

* Contact: elijah, azul
* Difficulty: Easy to medium
* Skills: Ruby and Javascript

### Dynamic form validation

Any form element should have dynamic feedback for the user. For example, if you tried to add the username "hello im an username with spaces", a message should come up on the page that says that you cannot have a username with spaces. 

* Contact: elijah, azul
* Difficulty: Easy
* Skills: Ruby and Javascript

### Help ticket routing

If there is a problem with the bitmask application itself, it doesn't make sense to send that to the provider, it should be sent to the bitmask development team. This this could be something that could be changed for different classes of help tickets, and  something that links to other ticketing systems.

* Contact: elijah, azul
* Difficulty: Medium
* Skills: Ruby
