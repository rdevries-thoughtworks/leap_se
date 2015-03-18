- @title = 'Transitional rules for automated key validation'
- @nav_title = 'Transitional Key Validation'
- @summary = 'Generic rules for automatic key management utilizing proper TOFU with a defined path to transition to future schemes of key validation.'

Introduction
===================================

Although many interesting key validation infrastructure schemes have been
recently proposed, it is not at all clear what someone writing secure email
software today should do. In particular, most of the new opportunistic
encrypted email projects have proposed starting with some sort of Trust On
First Use, but there are many ways to implement TOFU and many ways TOFU can
interact with whatever more advanced schemes are adopted in the future.

This document attempts to specify generic rules for automatic key management
that can form a basis for proper TOFU and to transition from TOFU to more
advanced forms of key validation. In particular, the rules try to define when
a user agent should use one public key over another. These rules are agnostic
concerning what form these future systems of key validation take.

For systems that enforce a single channel for discovery and validation, these
rules are not useful. This document is only useful for the messy situation we
find ourselves in at the present time: there is a large gap between what
systems should do now in order to be immediately useful in the current OpenPGP
ecosystem and what should be done in the future.

This document is written from the point of view of Alice, a user who wants to
send an encrypted email to Bob, although she does not yet have his public key.

We assume:

* The goal is to automate the process of binding an email address to a public
  key (we don't care about real identities).
* Alice knows Bob's email address, but not his public key.
* Alice might be initiating contact with Bob, or he might be initiating
  contact with her.
* Bob might use an email provider that facilitates key discovery and/or
  validation in some way, or he might not.

Unless otherwise specified, "key" in this text always means "public key".

Definitions
---------------------

* key manager: The key manager is a trusted user agent that is responsible for
  storing a database of all the keys for the user, updating these keys, and
  auditing the endorsements of the user's own keys. Typically, the key manager
  will run on the user's device, but might be running on any device the user
  chooses to trust.
* key directory: An online service that stores public keys and allows clients
  to search for keys by address or fingerprint. A key directory does not make
  any assertions regarding the validity of an address + key binding. Existing
  OpenPGP keyservers are a type of key directory in this context, but several
  of the key validation proposals include new protocols for key directories.
* key discovery: The act of encountering a new key, either inline the message,
  via URL, or via a key directory.
* key validation level: the level of confidence the key manager has that we
  have the right key for a particular address. For automatic key management,
  we don't say that a key is ever "trusted" unless the user has manually
  verified the fingerprint.
* key registration: the key has been stored by the key manager, and assigned a
  validation level. The user agent always uses registered keys. This is
  analogous to adding a key to a user's keyring, although implementations may
  differ.
* key endorser: A key endorser is an organization that makes assertions
  regarding the binding of username@domain address to public key, typically by
  signing public keys. When supported, all such endorsement signatures must
  apply only to the uid corresponding to the address being endorsed.
* binding information: evidence that the key manager uses to make an educated
  guess regarding what key to associate with what email address. This
  information could come from the headers in an email, a DNS lookup, a key
  endorser, etc.
* verified key transition: A process where a key owner generates a new
  public/private key pair and signs the new key with a prior key. Someone
  verifying this new key then must check to see if there is a signature on the
  new key from a key previously validated for that particular email address.
  In effect, "verified key transition" is a process where verifiers treat all
  keys as name-constrained signing authorities, with the ability to sign any
  new key matching the same email address. In the case of a system that
  supports signing particular uids, like OpenPGP, the signatures for key
  transition must apply only to the relevant uid.
* endorsement key: The public/private key pair that a service provider or
  third party endorser uses to sign user keys.

Key manager rules
====================================

1. **First Contact:** When one or more keys are first discovered for a
   particular email address, the key with the highest validation level is
   registered.
2. **Regular Refresh:** All keys are regularly refreshed to check for modified
   expirations, or new subkeys, or new keys signed by old keys (precisely how
   updates work is out of scope of this document).
    a. This refresh should happen via some anonymizing mechanism.
    b. The expiration date on a key should not ever be reduced, unless it can
       be proved that this is a newer version of the key.
3. **Key Replacement:** A registered key MUST be replaced by a new key in one
   of the following situations, and ONLY these situations:
    a. verified key transitions (when the new key is signed by the previously
       registered key for same address).
    b. If the user manually verifies the fingerprint of the new key.
    c. If the registered key is expired or revoked and the new key is of equal
       or higher validation level.
    d. If the registered key has never been successfully used and the new key
       has a higher validation level.
    e. If the registered key has no expiration date.

Previously registered keys must be retained by the key manager, for the
purpose of signature authentication. These old keys are never used for sending
messages, however. Keys older than X may be forgotten.

A public key for Bob is considered "successfully used" by Alice if and only if
Alice has both sent a message encrypted to the key and received a message
signed by that key.

In practice, a key manager likely will implement rule 1 by trying every
possible validation and discovery method it supports, from highest level to
lowest, until it first gets a key and then it will stop.

Validation levels
====================================

Listed from lowest to highest validation level.

1. weak-chain
---------------------------

Bob's key is obtained by Alice from a non-auditable source via a weak chain.
By weak chain, we mean that the chain of custody for "binding information" is
broken. In other words, somewhere a long the way, the binding information was
transmitted over a connection that was not authenticated.

This form of key validation is very weak, and should either be forbidden by
the key manager or phased out as soon as practical.

Examples:

* Alice initiates key discovery because she wants to send an email to Bob.
  Alice queries the OpenPGP keyservers for an address that matches Bob's. This
  is a weak chain because anyone can upload anything to keyservers.
* Bob initiates key discovery by sending Alice an email that is signed, but
  Bob's email provider does not support DKIM. Alice takes the fingerprint from
  the signature and queries the OpenPGP keyservers to discover the key. This
  is a weak chain because there is nothing to stop anyone from sending an
  email that impersonates Bob with a fake "From" header and fake signature.

2. provider-trust
----------------------------

Alice obtains binding information for Bob's key from Bob's service provider,
via a non-auditable source over a strong chain. By strong chain, we mean that
every connection in the chain of custody for "binding information" from Bob's
provider to Alice is authenticated. To subvert "provider-trust" validation, an
attacker must compromise Bob's service provider or a certificate authority (or
parent zones when using DNSSEC), but it also places a high degree of trust on
service providers and CAs.

Examples:

* Bob initiates key discovery by sending Alice an email that is signed by Bob,
  and there is a valid DKIM signature from the provider for the "From" header
  and the full body. Alice takes the fingerprint from the signature and
  queries the OpenPGP keyservers to discover the key. This is "provider-trust"
  because the DKIM signature binds the sender address to the fingerprint of
  Bob's key, and presumably Bob authenticated with his service provider. This
  also assumes Alice's user agent is able to securely discover the DKIM public
  key for Bob's provider. Also, in practice, no one ever DKIM signs the
  message body, so this example is just hypothetical.
* Alice initiates key discovery for Bob's address, checking webfinger or DNS.
  These queries by Alice are 'provider-trust' so long as the webfinger request
  was over HTTPS (and the server presented a certificate authenticated by a CA
  known to Alice) or the DNS request used DANE/DNSSEC. This relies on a
  reasonable assumption that if a provider publishes keys via DNSSEC or HTTPS
  then the provider probably also required some authentication from the user
  when the user uploaded their public key. Bob initiates key discovery by
  sending Alice an email that contains an OpenPGP header that specifies a URL
  where Alice may obtain Bob's public key. Bob's email contains no DKIM
  signature, so it could have been sent by anyone. However, the URL is in a
  standard form such as [https://example.org/.well-known/webfinger?resource=acct:bob@example.org](#).
  If the "From" header matches the domain, the URL is in a standard form, the
  email address in the URL, and the HTTPS connection is authenticated, then
  Alice may consider this "provider-trust." This is because, regardless of who
  actually sent the email, what Alice sees as the sender matches what the
  provider is queried for. All these conditions are unlikely to be met in
  practice, but the example serves to illustrate the broader point.

3. provider-endorsement
----------------------------------------

Alice is able to ask Bob's service provider for the key bound to Bob's email
address and Bob is able to audit these endorsements. Rather than simple
transport level authenticity, these endorsements are time stamped signatures
of Bob's key for a particular email address. These signatures are made using
the provider's 'endorsement key'. Alice must obtained and register the
provider's endorsement key with validation level at 'provider-trust' or
higher.

An auditable endorsing provider must follow certain rules:

* The keys a service provider endorses must be regularly audited by its users.
  Alice has no idea if Bob's key manager has actually audited Bob's provider,
  but Alice can know if the provider is written in such a way that the same
  client libraries that allow for submitting keys for endorsement also support
  auditing of these endorsements. If a key endorsement system is not written
  in this way, then Alice's key manager must consider it to be the same as
  "provider-trust" validation.
* Neither Alice nor Bob should contact Bob's service provider directly.
  Provider endorsements should be queried through an anonymizing transport
  like Tor, or via proxies. Without this, it is easy for provider to prevent
  Bob from auditing its endorsements, and the validation level is the same as
  "provider-trust". With provider-endorsement, a service provider may
  summarily publish bogus keys for a user. Even if a user's key manager
  detects this, the damage may already be done. However, "provider-
  endorsement" is a higher level of validation than "provider-trust" because
  there is a good chance that the provider would get caught if they issue
  bogus keys, raising the cost for doing so.

4. third-party-endorsement
---------------------------------------

Alice asks a third party key endorsing service for binding information, using
either an email address of key fingerprint as the search term. This could
involve asking a key endorser directly, via a proxy, or asking a key directory
that includes endorsement information from a key endorser.

A key endorser must follow certain rules:

* The key endorser must be regularly audited by the key manager. Alice has no
  idea if Bob's key manager has actually audited a particular key endorser,
  but Alice can know if the key endorser is written in such a way that the
  same client libraries that allow for submitting keys for endorsement also
  support auditing of these endorsements. If a key endorsement system is not
  written in this way, then Alice's key manager must consider it to be the
  same as "provider-trust" validation.
* The key endorser must either require verified key transitions or require
  that old keys expire before a new key is endorsed for an existing email
  address. This is to give a key manager time to prevent the user's service
  provider from obtaining endorsements for bogus keys. If a key endorsement
  system is not written in this way, Alice's key manager must consider it to
  have the same level of validation as "provider-endorsement".

5. third-party-consensus
-----------------------------------

This is the same as third-party endorsement, but Alice's user agent has
queried a quorum of third party endorsers and all their endorsements for a
particular user address agree. A variant of this could be "n-of-m" validation,
where Alice's user agent requires 'n' endorsements from a set of 'm'
endorsers.

6. historical-auditing
-----------------------------------

This works similar to third-party-endorsement, but with better ability to
audit key endorsements. With historical auditing, a key endorser must publish
an append-only log of all their endorsements. Independent "auditor" agents can
watch these logs to ensure new entries are always appended to old entries.

The benefit of this approach is that an endorser is not able to temporarily
endorse and publish a bogus key and then remove this key before Alice's key
manager is able to check what key has been endorsed. The endorser could try to
publish an entire bogus log in order to endorse a bogus key, but this is very
likely to be eventually detected.

As with other endorsement models, the endorsement key must be bootstrapped
somehow using a validation level of "provider-trust" or higher.

7. known-key
-----------------------------------

Bob's key has been hard-coded as known by the software (mostly this just
applies to keys belonging to established endorsers, not user keys).

8. fingerprint
----------------------------------

Alice has manually confirmed the validity of the key by inspecting the full
fingerprint or by using a short authentication string with a limited time
frame. For extra whimsy, fingerprint inspection should take the form of a
poem.

Future specification
===================================

These are out of scope for the specific problem of key validation, but these
are important issues that need to be addressed when transitioning to
opportunistic encrypted email over time.

Issuing new keys
--------------------------

As these rules are written, if Alice loses her private key but still has
access to her email account, she will not be able to send signed mail or
receive encrypted mail until the expiration date on the key (assuming all the
clients respect the key expiration date). If the key has no expiration date,
then the key manager should just accept new keys.

For example, imagine Alice loses access to her private key but the key will
not expire for another month. She can still authenticate with her service
provider, so she can still issue new keys and have the service provider
endorse them, or some other party endorse them. But, no valid client should
use them yet until her lost key expires.

Effectively, the primary key's expiratation date is the window of time that
Alice is willing to put up with being locked out of using encrypted email.
This window is also the same length of time that Alice has of detecting, by
audit, a provider that is publishing bogus keys for her (before those keys
potentially start to get used). So, if Alice wants high convenience, she can
set this window to be short (or have no expiration). If Alice wants higher
security, she can set this window to be long.

At this point, it is unclear what a good value for key expiration should be
for users who want higher convenience and for users who want higher security.
If a key expiration date is too soon, then there is a possibility that Alice's
key manager will not have had the opportunity to extend the key expiration
(for example, perhaps Alice is traveling and does not check email for several
weeks). Alice can still recover, since a key can still have its expiration
date extended after the key has expired, but this is still not ideal.

Updating keys
--------------------------

For high usability, a key manager will need to frequently update keys by
querying a key directory or the original source of the key. Every key
validation proposal has a different mechanism for this. The important thing is
that Alice's key manager should not make queries in a manner that leaks
Alice's addressbook to the key directories. As one example, the program
parcimonie will slowly update keys, one at a time, from traditional OpenPGP
keyservers over Tor. Also, because these updates need to happen frequently,
the key manager should have some way to first test to see if a key is modified
before downloading the full key (using something like an etag).

Sending email
--------------------------

To avoid encrypted email being sent to people who no longer use OpenPGP, the
user agent should not opportunistically encrypt outgoing mail to a recipient
unless the recipient has positively indicated they wish to receive encrypted
email. Such indication may include: a signed email message, a public key as an
attachment, an OpenPGP header, a key published by the provider or key
directory (but NOT a HKP keyserver), or when the user performs manual
fingerprint verification. When Alice sends an email with an opportunistic mail
user agent, the agent should always try to indicate that Alice prefers
encrypted email. This could be done by signing every message, although that
can raise security issues as well.

Receiving email
--------------------------

As alluded to above, an opportunistic mail user agent that receives a message
from a provider that does not support DKIM signatures on the From header
should be cautious when using the OpenPGP signature or OpenPGP header to
discover and register the sender's public key. These emails are easily spoofed
by anyone on the internet, causing the user agent to register impostor keys.

Device keys and subkeys
--------------------------

It would be highly desirable for all projects that use OpenPGP to support
device keys. The idea is that a user might have multiple devices, with
different keys for each device (instead of needing to synchronize the same
private key to all their devices). How might this work?

If Bob's master key has multiple subkeys with (E)ncryption usage for the uid
in question, then Alice should encrypt the message to ALL those subkeys when
sending email to Bob.

A system using subkeys like this still requires a single master key. It may be
desirable for a key validation protocol to allow for a single email address to
be bound to multiple master public keys, although this is not supported with
the current rules in this document.

Phasing out
--------------------------

Ideally, there should be some mechanism to phase out lower forms of validation
as higher forms become more common. In particular, it would be good to forbid
weak-chain validation entirely.

Critique
==========================

Thus far, there have been two critiques of the key management rules as
described here.

Lost keys
--------------------------

The first problem occurs when the owner loses access to their private key.
After a user has lost their private key, clients that follow the rules here
will not accept the new key until the prior public key has expired or unless
other people manually import the new key.

One alternate approach is to present the user with a choice when a new key
appears (that does not have a verified key transition) and ask the user if
they want to accept this key (or possibly just notify them that the key has
changed). On closed systems, such as TextSecure, this approach makes sense,
because there are fewer parties who are able to inject bogus keys into the
system. In a federated system, however, there are many ways one can inject new
bogus keys, and so we have felt that it is better to just always reject new
keys and not require user interaction when new keys are discovered.

Stolen keys
--------------------------

If an attacker is able to gain access to a user's private key, then this
scheme will make the situation worse than it already is. This is because a
system for 'verified key transitions' will allow the attacker to issue a new
public key, publish it, and make it so that the target of the attack is no
longer able to read any of their incoming encrypted mail.

On balance, we felt that it is still a good idea to support automatic
'verified key transitions'. There are many legitimate reasons why you would
want to entirely regenerate your master signing key. In the community of
OpenPGP users that we communicate with, verified key transitions are
commonplace. Key transitions are likely to be common in the future when people
upgrade to 25519 OpenPGP keys.

