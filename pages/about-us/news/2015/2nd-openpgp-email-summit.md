@title = '2nd OpenPGP email summit'
@author = 'meskio'
@posted_at = '2015-12-10'
@more = true
@preview_image = '/img/pages/gnupg.png'
@preview = "We participated in the 2nd OpenPGP email summit were we had the oportunity to exchange ideas with many other projects."

The [2nd OpenPGP email summit](https://wiki.gnupg.org/OpenPGPEmailSummit201512) took place in Zurich between the 5th and 6th of December. LEAP was there among many other projects working on protecting email communications. It was an intense weekend where we had the oportunity to hear from other projects about how they are doing things and to discuss how to solve common problems.

There were many working sessions on a variety of topics (from key server email validation to password recovery). I'm going to highlight some topics that I think were very interesting.

# Encrypted Indexes

We talked about how to index inboxes in a privacy preserving way. Considering how most users access their email nowadays, on a web browser loading what they need on demand, we talked about how that could be done in a secure manner.

Assume that you have the index perfectly secure, or locally stored or secured in a nifty way in your provider where you can do queries and the provider can not guess the content of the queries. Let's first assume that you have your emails stored as they arrive, your encrypted email is stored encrypted and your decrypted email is stored decrypted. After each query you retrieve the resulting emails, so the server sees which decrypted emails are related to which encrypted ones and in the long term can infer the content of the encrypted ones as well.

Let's imagine then that you store all the emails encrypted. Then your provider could send to you crafted emails with the kind of content she cares to discover, so the provider can notice each time you retrieve one of these crafted emails and what other emails are related to that. You could minimize this attack by not only fetching the emails that you care about, but fetching way more. So, the options are: either you keep your whole set of emails locally, or otherwise the server will be able to infer data about the encrypted emails.

We reached the conclusion that the only privacy preserving way to access the email is to have the whole archive of the email locally accessible. We need to get back to the 90s. This is what we do in LEAP.

# Header Encryption and Signing with "Memory Hole"

Currently, when an email arrives signed and/or encrypted your headers are not part of the signature or encryption, although user expectations are to the contrary. For example, that means when an email is signed and you are sure that it comes from the sender an attacker could replace the subject, changing completely the meaning of the email. Same happens with encryption: the headers are not protected and can be read by an attacker.

For the last 6 months there has being ongoing conversations between most of OpenPGP email projects about securing email headers. The main project that is getting support by most of the clients is [Memory Hole](https://modernpgp.org/memoryhole/).

Memory Hole aims to solve this problem by copying some headers in the PGP/MIME part so they get signed and/or encrypted. In the case of encryption, some headers can be removed or replaced from the email headers to protect their privacy. One of the major problems about proposing a new format to secure headers is how to make it backward compatible so email clients of today (without Memory Hole support) can display the removed/replaced headers in a meaningful way to the user. Memory Hole proposes to solve that by placing the user facing headers in a MIME part so most email clients today will render them on top of the body.

We had many interesting conversations on how Memory Hole will work, what are its corner cases or how the UX should be able to display to the user the security status of each header.

# Scaling Key Servers

The Google's e2e project is working on ways to endorse keys from the provider in an auditable way. They are taking ideas from [CONIKS](http://www.coniks.org/) and [Certificate Transparency](https://www.certificate-transparency.org/) to create a robust system.

Their proposal is to have a log of all the published keys in each provider, this log keeps all its history in a way that you can not modify past records without modifying the latest one. There will be monitors run by independent organizations that observe these logs. So when Alice wants to discover the key of Bob, she can ask Bob's provider for the key and check with one of these monitors to certify that the key she is obtaining is the same than Bob's provider is publishing to everybody else. Bob can also audit that his provider is publishing his own key and not a malicious one using this monitors.

The system is designed in a way that is easy to retrieve the key of someone, but hard to discover the list of keys available. So an attacker can't easily find all the email addresses in the provider.

The system is complicated and will need some time to be reviewed and discussed by the community, but has potential. There are still many questions about things like how to react if a provider is found publishing malicious keys.

# Conclusions

Meeting with other email projects working with OpenPGP is very productive. As someone said this weekend, the bandwidth is huge for exchanging ideas during in person meetings. LEAP was happy to be there, we leaned a huge amount from what other projects are doing and came back with a lot of ideas for how we can improve and collaborate.

Everybody left motivated to have more summits in the future. If everything goes well there will be another OpenPGP Email Summit in half a year.
