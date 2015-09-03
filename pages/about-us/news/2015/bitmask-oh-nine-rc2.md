@title = "Bitmask 0.9.0rc2 release candidate"
@author = "LEAP"
@posted_at = '2015-09-03'
@more = true
@preview_image = '/img/pages/bitmask.png'
@preview = %(The LEAP team is pleased to announce the immediate availability of the second release candidate for Bitmask 0.9.0, codename "we're not in kansas anymore.")

The LEAP team is pleased to announce the immediate availability of the second
release candidate for Bitmask 0.9.0, codename "we're not in kansas anymore".

This is our second public release candidate with a responsive and relatively
bug free encrypted email experience. Our work has focused on speed and scale
optimization by adapting the underlying components (leap.keymanager and
leap.mail) to use the new async API of Soledad. This reduces code complexity by
making use of the reactor pattern and by having blocking code (i.e. general
i/o) be executed asynchronously. We have revamped how the bitmask frontend and
backend communicates (this improves performance and prevents bugs), improved
log handling for better bug reports, and much more (see the changelog file for
a more detailed list).

This is a release candidate aimed at getting more user feedback to influence
our next round of development. We have a list of known issues
(https://leap.se/code/versions/161 /
https://leap.se/en/docs/client/known-issues ) that we are cranking through and
will add more to the list as feedback comes in.

Changelog:
https://github.com/leapcode/bitmask_client/blob/0.9.0rc2/CHANGELOG.rst


Hacking and Testing
-----------------------

To get started you should download rc2 and signatures:
https://dl.bitmask.net/client/linux/release-candidate/

If you never used the standalone bundle before you can take a look the docs for
stable releases:
https://bitmask.net/en/install/linux#install-stand-alone-bundle

Here are some tips for RC testing that you can use:
https://github.com/leapcode/bitmask_client/blob/develop/docs/testing-rcs.README

As always, your testing and hacking skills are welcome! If you'd like to get
involved look here https://leap.se/en/docs/get-involved for tips on contacting
the developers, getting start hacking on Bitmask, and reporting bugs. User
testers start here: https://leap.se/en/docs/client/

And you never know, you may also run into us drinking mate, sleepless in night
trains, rooftops, rainforests, lonely islands and, always, beyond any border.

The LEAP team,

September, 2015
Somewhere in the middle of the intertubes.
EOF
