@title = "Email and its discontents"
@nav_title = "Email"

<img src="/img/animated-gifs-email-007.gif" align="right" />

Email continues to be a vital communication tool. Unfortunately, the email protocol was designed in the Paleocene era of the internet and is unable to cope with the security threats common today.

For example, there is no standard for ensuring secure relay between mail providers (StartTLS is easily thwarted) and message encryption technology (OpenPGP and S/MIME) has proven to be too cumbersome to reach beyond a very small audience. Even these existing methods, however, offer no protection against meta-data analysis since the email headers remain unencrypted. Finally, email providers have an unfortunate habit of handing over users' data to non-democratic regimes.

## Email for the modern era

The LEAP approach to email is to support communication with the legacy email infrastructure while also adding optional layers to the protocol that bring email more in line with modern security practices. This strategy allows for a gradual transition from existing email to secure email. In the short term, there are immediate benefits to a user's security when they adopt LEAP email. In the long term, as more service providers adopt the LEAP platform, email among these service providers gains even more protection.

Above all else, our focus is on creating a user experience that is as easy and trouble-free as possible while still ensuring a very high level of security.

## How it works

When a service provider runs the LEAP platform, their users can access secure email in three steps:

1. Download and install the Bitmask application.
2. Run the Bitmask application to log in or sign up with the service provider.
3. Configure the user's mail client to connect to the local Bitmask application. In case of the Thunderbird email client, this configuration is semi-automatic.

The Bitmask application acts as a "proxy" between the service provider and the mail client. It handles all the encryption and data synchronization.

## Immediate benefits of using LEAP email

Email features include:

* LEAP encrypted email is easy to use while still being backward compatible with the existing OpenPGP protocol for secure email.
* All incoming email is automatically encrypted before being stored, so only you can read it (including meta-data).
* Whenever possible, outgoing email is automatically encrypted so that only the recipients can read it (if a valid OpenPGP public keys can be discovered for the recipients). This encryption takes place on the user's device.
* OpenPGP public keys are [automatically discovered and validated](/nicknym), allowing you to have confidence your communication is confidential and with the correct person (without the headache of typical key signing).
* The user does not need to worry about key management. Their keys are always kept up-to-date on every device.
* The user is able to use any email client of their choice (e.g. Thunderbird, Apple Mail, Outlook).
* When disconnected from the internet, the user can still interact with a local copy of all their mail. When the internet connect is available again, all their changes will get synchronized with the server storage and to their other devices.

General security features of the Bitmask application include:

* All stored data is encrypted, including local data and cloud backups. This encryption always [takes place on the user's device](/soledad), so the service provider cannot read your stored data.
* Although you specify a username and password to login, your [password is never communicated to the provider](https://en.wikipedia.org/wiki/Secure_Remote_Password_protocol).
* If you download the Bitmask application from [downloads.leap.se](https://downloads.leap.se), your service provider cannot add a backdoor to compromise your security.
* The Bitmask application is always kept up to date with the latest security patches (coming soon).

## Long term benefits when two LEAP compatible providers talk to one another

One of the fundamental problems with email is that the meta-data routing information is exposed as cleartext. Encrypting a message with OpenPGP or S/MIME does nothing to help with this.

The email protocol does support an optional method of securely relaying messages using TLS to encrypt the connection. This method, called StartTLS, is easily undermined by attackers and there is no good way for email providers to validate the authenticity of other servers (without relying on the problematic CA certificate authority system).

For now, LEAP addresses these problems with two enhancements when two compatible providers are talking to one another:

* When relaying email, server keys are discovered and validated using DNSSEC/DANE.
* For these providers, TLS with validated keys becomes required for all communication.

This approach is effective against external network observers, but does not protect the meta-data from the service providers themselves. Also, it does not, by itself, protect against more advanced attacks involving timing and traffic analysis.

In the long term, we plan to adopt one of several different schemes for [securely routing meta-data](routing).

## Limitations

* Missing features: the initial release will not support email aliases, email forwarding, or multiple accounts simultaneously.
* You cannot use LEAP email from a web browser. It requires the Bitmask application to run.
* The Bitmask application currently requires a compatible provider. We have plans in the future to semi-support commercial providers like gmail. This would provide the user with much less protection than when they use a LEAP provider, but will still greatly enhance their email security.
* Because all data is synced, if a user has one of their devices compromised, then the attacker has access to all their data. This is obvious, but worth mentioning.
* The user must keep a complete copy of their entire email storage on every device they use. In the future, we plan to support partial syncing for mobile devices.
* We do not plan to support key revocation. Instead, we plan to migrate to shorter and shorter lived keys, as practical.
* With the current implementation, a compromised or nefarious service provider can still gather incoming messages that are not encrypted and meta-data routing information. As more users and providers adopt secure email, many of these problems will go away.

For more details, please see [known limitations](limitations).

## Related projects

There are numerous other projects working on the next generation of secure email. In our view, it is not possible to do secure email alone, it requires new protocols for handing key validation, secure transport, and meta-data protection. We will continue our efforts to reach out to these groups to explore areas of cooperation.

Free software projects

* [mailpile.is](http://mailpile.is/) - Python email client with a web interface, optimized searching, and support for OpenPGP.
* [mailiverse.com](https://mailiverse.com) - HTML5 app. Sparse on details.

Mixed proprietary and free software projects

* [mega.co.nz](https://mega.co.nz/) - Mega has announced plans for web-based encrypted email, but no details yet. In-browser javascript client will reportedly be open source, backend not.

Proprietary projects

* [parley.co](http://parley.co) - Proprietary OpenPGP client and service. Few details so far.
* [startmail.com](https://startmail.com/) - No details yet.
* [Places](https://ansamb.com/) - Announced secure email, no details yet.

Initiatives

* Ubiquitous Encrypted Email - A private, invite-only mailing list to discuss new ways to make encrypted email commonplace.

Email-like, but incompatible with existing email

* [pond](https://pond.imperialviolet.org/) - Forward secure, asynchronous, peer-to-peer email-like messenger. Addresses are the key fingerprint. Free software, written in Go.
* [bitmessage](https://bitmessage.org) - Peer-to-peer messaging application. Addresses are the key fingerpint. Free software.
* [scrable.io](https://scramble.io/doc/) - Free software, web email, but using the key fingerprint as the email address.