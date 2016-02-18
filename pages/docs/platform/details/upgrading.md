@title = 'Upgrading'
@nav_title = 'Upgrading'
@summary = "Upgrading the platform and the OS"
@toc = true


Upgrading the platform
======================

From 0.7.1 to 0.8
=================

Next to other changesm 0.8 introduces several major changes that need do get taken into account while upgrading:

- Dropping Debian Wheezy support. You need to upgrade your nodes to jessie before deploying a platform upgrade.
- Dropping Bigcouch support. LEAP Platform now requires couchdb and therefore you need to migrate from bigcouch to couchdb.

Here's how to upgrade from wheezy nodes running bigcouch to jessie nodes using couchdb:

- Follow https://leap.se/en/docs/platform/services/couchdb#migrating-from-bigcouch-to-plain-couchdb, but only until the step where you removed bigouch.

- Now upgrade to jessie (see the Howto below)

- Continue with https://leap.se/en/docs/platform/services/couchdb#migrating-from-bigcouch-to-plain-couchdb at the point where you stopped for the first step, and deploy to the couchdb node.


Upgrading the operating system
==============================

From Debian Wheezy to Jessie
----------------------------

There are the [Debian release notes on how to upgrade from wheezy to jessie](https://www.debian.org/releases/stable/amd64/release-notes/ch-upgrading.html).
He're the steps that worked for us, but please keep in mind that this is not a bullet-prove documentation, so use it on your own risk:

    screen
    script -t 2>~/leap_upgrade-jessiestep.time -a ~/upgrade-jessiestep.script

    apt-get autoremove
    apt-get update
    DEBIAN_FRONTEND=noninteractive apt-get -y -o DPkg::Options::=--force-confold dist-upgrade
 
    dpkg --audit
    dpkg --get-selections | grep 'hold$'
    # if anything is held, you need to resolve it before continuing.

    apt-get clean

    # switch sources to jessie
    sed -i 's/wheezy/jessie/g' /etc/apt/sources.list
    echo "deb http://deb.leap.se/0.8 jessie main" > /etc/apt/sources.list.d/leap.list

    # remove pinnings to wheezy
    rm /etc/apt/preferences

    apt-get update

    # test there is enough space for the upgrade
    apt-get -o APT::Get::Trivial-Only=true dist-upgrade

    # do first stage upgrade
    DEBIAN_FRONTEND=noninteractive apt-get -y -o DPkg::Options::=--force-confold upgrade

    # repeat dist-upgrade until it makes no more changes:
    DEBIAN_FRONTEND=noninteractive apt-get -y -o DPkg::Options::=--force-confold dist-upgrade

    # resolve any apt issues if there are some
    apt-get -f install

    reboot








### Issues

- Failure restarting some services for OpenSSL upgrade

If you get this warning:

    The following services could not be restarted for the OpenSSL library upgrade:
      postfix
    You will need to start these manually by running '/etc/init.d/<service> start'.

Just ignore it, it should be fixed on reboot/deploy.

