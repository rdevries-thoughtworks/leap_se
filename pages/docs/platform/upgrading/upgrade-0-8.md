@title = 'Upgrade to 0.8'
@toc = false

LEAP Platform release 0.8 introduces several major changes that need do get taken into account while upgrading:

* Dropping Debian Wheezy support. You need to upgrade your nodes to jessie before deploying a platform upgrade.
* Dropping BigCouch support. LEAP Platform now requires CouchDB and therefore you need to migrate all your data from BigCouch to CouchDB.

Upgrading to Platform 0.8
---------------------------------------------

### Step 1: Get new leap_platform and leap_cli

    workstation$ gem install leap_cli --version 1.8
    workstation$ cd leap_platform
    workstation$ git pull
    workstation$ git checkout 0.8.0

### Step 2: Migrate BigCouch to CouchDB

First migrate your BigCouch nodes to CouchDB.

At the end of this process, you will have just *one* node with `services` property equal to `couchdb`. If you had a BigCouch cluster before, you will be removing all but one of those machines to consolidate them into one CouchDB machine.

1. if you have multiple nodes with the `couchdb` service on them, pick one of them to be your CouchDB server, and remove the service from the others. If these machines were only doing BigCouch before, you can remove the nodes completely with `leap node rm <nodename>` and then you can decommission the servers

1. put the webapp into maintenance mode:

Simply drop a html file to `/srv/leap/webapp/public/system/maintenance.html`. For example:

    workstation$ leap ssh <webapp-node>
    server# echo "Temporarily down for maintenance. We will be back soon." > /srv/leap/webapp/public/system/maintenance.html

1. turn off daemons that access the database. For example:

    ```
    workstation$ leap ssh <each soledad-node>
    server# /etc/init.d/soledad-server stop

    workstation$ leap ssh <mx-node>
    server# /etc/init.d/postfix stop
    server# /etc/init.d/leap-mx stop

    workstation$ leap list webapp
    workstation$ leap ssh <webapp-node>
    server# /etc/init.d/nickserver stop
    ```

    Alternately, you can create a temporary firewall rule to block access (run on couchdb server):

    ```
    server# iptables -A INPUT -p tcp --dport 5984 --jump REJECT
    ```

1. remove orphaned databases and do a backup of all remaining, active databases. This can take some time and will place several hundred megabytes of data into /var/backups/couchdb. The size and time depends on how many users there are on your system. For example, 15k users took approximately 25 minutes and 308M of space:

    ```
    workstation$ leap ssh <couchdb-node>
    server# cd /srv/leap/couchdb/scripts
    server# ./cleanup-user-dbs
    server# time ./couchdb_dumpall.sh
    ```

1. stop bigcouch:

    ```
    server# /etc/init.d/bigcouch stop
    server# pkill epmd
    ```

1. remove bigcouch:

    ```
    server# apt-get remove bigcouch
    ```
1. configure your couch node to use plain couchdb instead of bigcouch, you can do this by editing nodes/<couch-node>.json, look for this section:

  ```
  "couch": {
    "mode": "plain"
  }
  ```

  change it, so it looks like this instead:

  ```
  "couch": {
    "mode": "plain",
    "pwhash_alg": "pbkdf2"
  }
  ```

### Step 3: Upgrade from Debian Wheezy to Jessie

There are the [Debian release notes on how to upgrade from wheezy to jessie](https://www.debian.org/releases/stable/amd64/release-notes/ch-upgrading.html). Here are the steps that worked for us, but please keep in mind that there is no bullet-proof method that will work in every situation. 

**USE AT YOUR OWN RISK.**

For each one of your nodes, login to it and do the following process:

    # keep a log of the progress:
    screen
    script -t 2>~/leap_upgrade-jessiestep.time -a ~/upgrade-jessiestep.script

    # ensure you have a good wheezy install:
    export DEBIAN_FRONTEND=noninteractive
    apt-get autoremove --yes
    apt-get update
    apt-get -y -o DPkg::Options::=--force-confnew dist-upgrade

    # if either of these return anything, you will need to resolve them before continuing:
    dpkg --audit
    dpkg --get-selections | grep 'hold$'

    # switch sources to jessie
    sed -i 's/wheezy/jessie/g' /etc/apt/sources.list
    rm /etc/apt/sources.list.d/*
    echo "deb http://deb.leap.se/0.8 jessie main" > /etc/apt/sources.list.d/leap.list

    # remove pinnings to wheezy
    rm /etc/apt/preferences
    rm /etc/apt/preferences.d/*

    # get jessie package lists
    apt-get update

    # clean out old package files
    apt-get clean

    # test to see if you have enough space to upgrade, the following will alert
    # you if you do not have enough space, it will not do the actual upgrade
    apt-get -o APT::Get::Trivial-Only=true dist-upgrade

    # do first stage upgrade
    apt-get -y -o DPkg::Options::=--force-confnew upgrade

    # repeat the following until it makes no more changes:
    apt-get -y -o DPkg::Options::=--force-confnew dist-upgrade

    # resolve any apt issues if there are some
    apt-get -f install

    # clean up extra packages
    apt-get autoremove --yes

    reboot


Issues
------

**W: Ignoring Provides line with DepCompareOp for package python-cffi-backend-api-max**

You can ignore these warnings, they will be resolved on upgrade.

**E: Unable to fetch some archives, maybe run apt-get update or try with --fix-missing?**

If you get this error, run `apt-get update` and then re-run the command.

**udev update errors**

On some systems, you may receive this long error:

```
Since release 198, udev requires support for the following features in
the running kernel:

- inotify(2)            (CONFIG_INOTIFY_USER)
- signalfd(2)           (CONFIG_SIGNALFD)
- accept4(2)
- open_by_handle_at(2)  (CONFIG_FHANDLE)
- timerfd_create(2)     (CONFIG_TIMERFD)
- epoll_create(2)       (CONFIG_EPOLL)
Since release 176, udev requires support for the following features in
the running kernel:

- devtmpfs         (CONFIG_DEVTMPFS)

Please upgrade your kernel before or while upgrading udev.

AT YOUR OWN RISK, you can force the installation of this version of udev
WHICH DOES NOT WORK WITH YOUR RUNNING KERNEL AND WILL BREAK YOUR SYSTEM
AT THE NEXT REBOOT by creating the /etc/udev/kernel-upgrade file.
There is always a safer way to upgrade, do not try this unless you
understand what you are doing!


dpkg: error processing archive /var/cache/apt/archives/udev_215-17+deb8u4_amd64.deb (--unpack):
 subprocess new pre-installation script returned error exit status 1
update-rc.d: warning: start and stop actions are no longer supported; falling back to defaults
update-rc.d: warning: start and stop actions are no longer supported; falling back to defaults
```

You can resolve this by doing: `touch /etc/udev/kernel-upgrade` and then
re-doing the upgrade command you were running when this error happened. Once you
are finished with the upgrade process, be sure to reboot.

**Unmet dependencies. Try using -f.**

Sometimes you might get an error similar to this (although the package names may be different):

    You might want to run 'apt-get -f install' to correct these.
    The following packages have unmet dependencies:
    lsof : Depends: libperl4-corelibs-perl but it is not installed or
                 perl (< 5.12.3-7) but 5.20.2-3+deb8u4 is installed

If this happens, run `apt-get -f install` to resolve it, and then re-do the previous upgrade command
you did when this happened.

**Failure restarting some services for OpenSSL upgrade**

If you get this warning:

    The following services could not be restarted for the OpenSSL library upgrade:
      postfix
    You will need to start these manually by running '/etc/init.d/<service> start'.

Just ignore it, it should be fixed on reboot/deploy.

### Step 4: Import Data into CouchDB

1. deploy to the couch node:

    ```
    workstation$ leap deploy <couchdb-node>
    ```

    If you used the iptables method of blocking access to couchdb, you need to run it again because the deploy just overwrote all the iptables rules:

    ```
    server# iptables -A INPUT -p tcp --dport 5984 --jump REJECT
    ```

1. restore the backup, this will take approximately the same amount of time as the backup took above:

    ```
    workstation$ leap ssh <couchdb-node>
    server# cd /srv/leap/couchdb/scripts
    server# time ./couchdb_restoreall.sh
    ```

### Step 5: Deploy everything

When you have upgraded all nodes to Jessie, you are ready to deploy:

    workstation$ cd <provider directory>
    workstation$ leap deploy

### Step 6: Test things are working

    workstation$ leap test

### Step 7: Cleanup

1. Remove old bigcouch data dirrectory on the couchdb node in `/opt`, after you double checked everything is in place

### Step 8: Relax

1. Relax, enjoy a refreshing beverage.
