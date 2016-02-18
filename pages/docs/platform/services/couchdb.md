@title = "couchdb"
@summary = "Data storage for all user data."

Topology
------------------------

`couchdb` nodes communicate heavily with `webapp`, `mx`, and `soledad` nodes. Typically, `couchdb` nodes will also have the `soledad` service.

`couchdb` nodes do not need to be reachable from the public internet, although the `soledad` service does require this.

Configuration
----------------------------

There are no options that should be modified for `couchdb` nodes.

NOTE: The LEAP platform is designed to support many database nodes. The goal is for you to be able to add nodes and remove nodes and everything should rebalance and work smoothly. Currently, however, we are using a broken CouchDB variant called BigCouch. Until we migrate off BigCouch, you should only have one `couchdb` node. More than one will work most of the time, but there are some bugs that can pop up and that are unfixed.

Manual Tasks
---------------------

### Rebalance Cluster

Bigcouch currently does not have automatic rebalancing.
It will probably be added after merging into couchdb.
If you add a node, or remove one node from the cluster,

. make sure you have a backup of all DBs !

. put the webapp into [maintenance mode](https://leap.se/en/docs/platform/services/webapp#maintenance-mode)
. Stop all services that access the database:

  * leap-mx
  * postfix
  * soledad-server
  * nickserver

. dump the dbs:

    cd /srv/leap/couchdb/scripts
    time ./couchdb_dumpall.sh

. delete all dbs
. shut down old node
. check the couchdb members

    curl -s —netrc-file /etc/couchdb/couchdb.netrc -X GET http://127.0.0.1:5986/nodes/_all_docs
    curl -s —netrc-file /etc/couchdb/couchdb.netrc http://127.0.0.1:5984/_membership


. remove bigcouch from all nodes

    apt-get --purge remove bigcouch


. deploy to all couch nodes

    leap deploy development +couchdb

. most likely, deploy will fail because bigcouch will complain about not all nodes beeing connected. Lets the deploy finish, restart the bigcouch service on all nodes and re-deploy:

    /etc/init.d/bigcouch restart


. restore the backup

    cd /srv/leap/couchdb/scripts
    time ./couchdb_restoreall.sh


### Migrating from bigcouch to plain couchdb

At the end of this process, you will have just *one* couchdb server. If you had a bigcouch cluster before, you will be removing all but one of those machines to consolidate them into one couchdb machine.

1. if you have multiple nodes with the couchdb service on them, pick one of them to be your couchdb server, and remove the service from the others. If these machines were only doing couchdb, you can remove the nodes completely with `leap node rm <nodename>` and then you can decommission the servers

1. put the webapp into [[maintenance mode => webapp#maintenance-mode]]

1. turn off daemons that access the database. For example:

    ```
    workstation$ leap ssh soledad-nodes
    server# /etc/init.d/soledad-server stop

    workstation$ leap ssh mx-node
    server# /etc/init.d/postfix stop
    server# /etc/init.d/leap-mx stop

    workstation$ leap ssh webapp
    server# /etc/init.d/nickserver stop
    ```

    Alternately, you can create a temporary firewall rule to block access (run on couchdb server):

    ```
    server# iptables -A INPUT -p tcp --dport 5984 --jump REJECT
    ```

1. remove orphaned databases and do a backup of all remaining, active databases. This can take some time and will place several hundred megabytes of data into /var/backups/couchdb. The size and time depends on how many users there are on your system. For example, 15k users took approximately 25 minutes and 308M of space:

    ```
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

1. configure your couch node to use plain couchdb instead of bigcouch. See section "Use plain couchdb instead of bigcouch" below for details.

1. deploy to the couch node:

    ```
    workstation$ leap deploy couchdb
    ```

1. restore the backup, this will take approximately the same amount of time as the backup took above:

    ```
    server# cd /srv/leap/couchdb/scripts
    server# time ./couchdb_restoreall.sh
    ```

1. start services again that were stopped in the beginning:

    ```
    workstation$ leap ssh soledad-nodes
    server# /etc/init.d/soledad-server start

    workstation$ leap ssh mx-node
    server# /etc/init.d/postfix start
    server# /etc/init.d/leap-mx start

    workstation$ leap ssh webapp
    server# /etc/init.d/nickserver start
    ```

    Or, alternately, if you set up the firewall rule instead, now remove it:

    ```
    server# iptables -D INPUT -p tcp --dport 5984 --jump REJECT
    ```

1. check if everything is working, including running the test on your deployment machine:

    ```
    workstation$ leap test
    ```

1. Remove old bigcouch data dir `/opt` after you double checked everything is in place

1. Relax, enjoy a refreshing beverage.

### Re-enabling blocked account

When a user account gets destroyed from the webapp, there's still a leftover doc in the identities db so other ppl can't claim that account without admin's intervention. You can remove this username reservation through the webapp.

However, here is how you could do it manually, if you wanted to:

grep the identities db for the email address:

    curl -s --netrc-file /etc/couchdb/couchdb.netrc -X GET http://127.0.0.1:5984/identities/_all_docs?include_docs=true|grep test_127@bitmask.net

lookup "id" and "rev" to delete the doc:

    curl -s --netrc-file /etc/couchdb/couchdb.netrc -X DELETE 'http://127.0.0.1:5984/identities/b25cf10f935b58088f0d547fca823265?rev=2-715a9beba597a2ab01851676f12c3e4a'

### How to find out which userstore belongs to which identity ?

    /usr/bin/curl -s --netrc-file /etc/couchdb/couchdb.netrc '127.0.0.1:5984/identities/_all_docs?include_docs=true' | grep testuser

    {"id":"665e004870ee17aa4c94331ff3ecb173","key":"665e004870ee17aa4c94331ff3ecb173","value":{"rev":"2-2e335a75c4b79a5c2ef5c9950706fe1b"},"doc":{"_id":"665e004870ee17aa4c94331ff3ecb173","_rev":"2-2e335a75c4b79a5c2ef5c9950706fe1b","user_id":"665e004870ee17aa4c94331ff3cd59eb","address":"testuser@example.org","destination":"testuser@example.org","keys": ...

* search for the "user_id" field
* in this example testuser@example.org uses the database user-665e004870ee17aa4c94331ff3cd59eb


### How much disk space is used by a userstore

Beware that this returns the uncompacted disk size (see http://wiki.apache.org/couchdb/Compaction)

    echo "`curl --netrc -s -X GET 'http://127.0.0.1:5984/user-dcd6492d74b90967b6b874100b7dbfcf'|json_pp|grep disk_size|cut -d: -f 2`/1024"|bc

## Use plain couchdb instead of bigcouch

Be aware that latest stable couchdb 1.6 cannot be clustered like bigcouch, so you can use this only if you have a single couchdb node.

Use this in your couchdb node config:

    "couch": {
      "master": true,
      "pwhash_alg": "pbkdf2"
    }

Local couch data dumps
======================

You can let one or more nodes do a nightly couchdb data dump adding this to your node config:

    "couch": {
      "backup": true
    }

Data will get dumped to `/var/backups/couchdb`.

Be aware that this will gather all data possibly shared over multiple nodes on one node.

