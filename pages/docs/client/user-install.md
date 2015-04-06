@nav_title = 'Installing'
@title = 'Installing Bitmask'

For download links and installation instructions go to https://dl.bitmask.net/

Distribute & Pip
----------------

**Note**

If you are familiar with python code and you can find your way through the
process of dependencies install, you can installing Bitmask using [pip](http://www.pip-installer.org/)
for the already released versions :

    $ pip install leap.bitmask

Our release cycle
-----------------

Once we have all features that we have planned for the next release of bitmask
ready we build a **release candidate** bundle. This bundle is heavily tested
before becoming stable. Here your contribution is important, we can not imagine
all they ways people uses bitmask, we need you to try it out, break it and
report back to us the problems. Read the [Bundle QA
section](/docs/client/bundle-testing) to learn how to help.

After extensive testing and being fixed all blocking issues we release the
**stable** bundle, what is meant for public consumption. This is the bundle that
is linked for download in the [bitmask web](https://bitmask.net/).

You can find all the bundles at https://dl.bitmask.net/client/

Automatic upgrades
------------------

The bundle uses [The Update Framework](http://theupdateframework.com/) (TUF) for
upgrades. If there is an upgrade available it will download it in background
when bitmask is running and ask you to restart bitmask to apply it.

We have two TUF repositories:
- **stable**. For the stable bundles. This allows the released bundles to
  upgrade to the next version automatically.
- **unstable**. For the *release candidate* (RC) bundles. The RC bundles upgrade
  automatically to the next RC bundle that we release, but never to the stable
  one. For example, if you are using the 0.7.0RC6 (the latest RC bundle for the
  0.7.0 version) you will not be upgraded to 0.7.0 but the next RC bundle
  released. The latest RC bundle should be exactly the same than the stable
  version with the difference of the TUF repos that are configured in them.

Packages
--------

For debian and ubuntu we build native packages and distribute them in our own
repositories. We have **stable** and **experimental** packages, experimental
packages are meant for testing, like the *release candidate* bundles.

The repository url looks like:

	deb http://deb.leap.se/[debian|experimental] [utopic|trusty|wheezy|jessy|sid] main

- **debian** are for stable packages.
- **experimental** are for experimental packages.
- **utopic** and **trusty** are the ubuntu versions.
- **wheezy**, **jessy** and **sid** are the debian versions.

More details on how to configure the repositories in your system in
https://dl.bitmask.net/linux/

Show me the code!
-----------------

For the brave souls that can find their way through python packages, you can
get the code from LEAP public git repository :

    $ git clone https://leap.se/git/bitmask_client

Or from the github mirror :

    $ git clone https://github.com/leapcode/bitmask_client.git

For more information go to the [Hacking](client/dev-environment) section :)

