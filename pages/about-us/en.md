@title = 'About Us'
@toc = false

LEAP is a dedicated to giving all internet users access to secure communication. Our focus is on adapting encryption technology to make it easy to use and widely available. Like free speech, the right to whisper is an necessary precondition for a free society. Without it, civil society and political freedom become impossible. As the importance of digital communication for civic participation increases, so does the importance of the ability to digitally whisper. LEAP is devoted to making the ability to whisper available to all internet users.

LEAP is a non-profit organization registered in the state of Washington, USA. THe people who create LEAP live around the world, including: Bahía Blanca (Argentina), Berlin (Germany), Hamburg (Germany), La Paz (Bolivia), London (UK), Madrid (Spain), Montreal (Quebec, Canada), New York City (NY, USA), Paris (France), Seattle (WA, USA), São Paulo (Brazil), Santiago (Chile).

# About LEAP technology

LEAP's approach is unique: we are making it possible for any service provider to easily deploy secure services and for people to use these services without needing to learn new software or change their behavior. These services are based on open, federated standards, but done right: the provider does not have access to the user's data, and we use open protocols in the most secure way possible.

On the server side we have created the LEAP Platform, a "provider in a box" set of complementary packages and server recipes automated to lower the barriers of entry for aspiring secure service providers. On the client side, we have created a cross-platform application called Bitmask that automatically configures itself once a user has selected a provider and which services to enable. Bitmask provides a local proxy that a standard email client can connect to, and allows for easy one-click Virtual Private Network (VPN) service.

Email continues to be a vital communication tool, but is difficult to use securely. Unfortunately, when people to use secure email they often use it in ways that compromise their confidentiality and the confidentiality of the people they communicate with. Even worse, current technology for secure email is vulnerable to numerous methods of association-mapping--information that can be highly sensitive in its own right.

The LEAP email system has several security advantages over typical encryption applications: if not already encrypted, incoming email is encrypted so that only the recipient can read it; email is always stored client-encrypted, both locally and when synchronized with the server; all message relay among service providers is required to be encrypted when possible; and public keys are automatically discovered and validated. In short, the Bitmask app offers full end-to-end encryption, quietly handling the complexities of public key encryption and allowing for backward compatibility with legacy email when necessary. Because the LEAP system is based on open, federated protocols, the user is able to change providers at will, preventing provider dependency and lock-in.

In addition to encrypted email, Bitmask offers automatically self-configuring encrypted internet proxy (aka VPN). Most VPN technology can be a pain to configure correctly without introducing vulnerabilities of DNS leakage, IPv6 leakage, and failing into an open, unencrypted state. The goals for LEAP’s VPN service are to make it so easy to use that people will want to keep it on all the time, and to make it more secure than most other VPN services.

For more information, see our [[documentation => docs]], [[talk slides => https://leap.se/slides/]], or [[bitmask.net => https://bitmask.net]].
