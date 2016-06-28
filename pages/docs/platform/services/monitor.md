@title = "monitor"
@summary = "Nagios monitoring and continuous testing."

The `monitor` node provides a nagios control panel that will give you a view into the health and status of all the servers and all the services. It will also spam you with alerts if something goes down.

Topology
--------------------------------------

Currently, you can have zero or one `monitor` nodes defined. It is required that the monitor be on the webapp node. It was not designed to be run as a separate node service.

Configuration
-----------------------------------------------

* `nagios.environments`: By default, the monitor node will monitor all servers in all environments. You can **optionally** restrict the environments to the ones you specify.

For example:

    {
      "nagios": {
        "environments": ["unstable", "production"]
      }
    }

Access nagios web
-----------------------------------------------

To open the nagios control panel:

    workstation$ leap open monitor

This will open a web browser window with the appropriate URL, including the nagios username and password.

If the URL does not open because of HSTS or DNS problems, pass the `--ip` option to `leap`.

If you are using an older version of `leap` command that doesn't include `leap open`, you can determine the nagio parameters manually:

Step 1. find the domain:

    workstation$ export DOMAIN=$(leap ls --print webapp.domain monitor | grep . | cut -f3 -d' ')

Step 2. find the username:

    workstation$ export USERNAME="nagiosadmin"

Step 3. find the password:

    workstation$ export PASSWORD=$(grep nagios_admin_password secrets.json | cut -f4 -d\")

Step 4. put it all together:

    workstation$ sensible-browser "https://$USERNAME:$PASSWORD@$DOMAIN/nagios3"
