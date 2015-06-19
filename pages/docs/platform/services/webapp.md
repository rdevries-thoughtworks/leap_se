@title = "webapp"
@summary = "leap_web user management application and provider API."

Introduction
------------------------

The service `webapp` will install the web application [[leap_web => https://leap.se/git/leap_web.git]]. It has performs the following functions:

* REST API for user registration and authentication via the Bitmask client.
* Admin interface to manage users.
* Client certificate distribution and renewal.
* User support help tickets.

Coming soon:

* Billing.
* Customizable and localized user documentation.

The leap_web application is written in Ruby on Rails 3, using CouchDB as the backend data store.

Topology
-------------------------

Currently, the platform only supports a single `webapp` node, although we hope to change this in the future.

`webapp` nodes communicate heavily with `couchdb` nodes.

Configuration
--------------------------

Essential options:

* `webapp.admin`: An array of username that will be blessed with administrative permissions. These admins can delete users, answer help tickets, and so on.

For example, `services/webapp.json`:

    {
      "webapp": {
        "admins": ["joehill", "ali", "mack_the_turtle"]
      }
    }

By putting this in `services/webapp.json`, all the `webapp` nodes will inherit the same admin list.

Customization
---------------------------

The provider directory `files/webapp` can be used to customize the appearance of the webapp. All the files in this directory will get sync'ed to the `/srv/leap/webapp/config/customization` directory of the deployed webapp node.

Files in the `files/webapp` can override view files, locales, and stylesheets in the leap_web app:

For example:

    stylesheets/ -- override files in Rails.root/app/assets/stylesheets
      tail.scss -- included before all others
      head.scss -- included after all others

    public/ -- overrides files in Rails.root/public
      favicon.ico -- custom favicon
      img/ -- customary directory to put images in

    views/ -- overrides files Rails.root/app/views
      home/
        index.html.haml -- this file is what shows up on
                           the home page
      pages/
        privacy-policy.en.md -- this file will override
                                the default privacy policy
        terms-of-service.en.md -- this file will override
                                  the default TOS.

    locales/ -- overrides files in Rails.root/config/locales
      en.yml -- overrides for English
      de.yml -- overrides for German
      and so on...

To play with these customizations, it is easiest to first modify the contents of the directory `/srv/leap/webapp/config/customization` on the `webapp` node. When doing this, you may need to restart leap_web in order for changes to take effect (`touch /srv/leap/webapp/tmp/restart.txt`).

Sometimes a `rake tmp:clear` and a rails restart is required to pick up a new stylesheet.

Once you have what you want, then copy these files to the local provider directory `files/webapp` so that they will be installed each time you deploy.

Custom Fork
----------------------------

Sometimes it is easier to maintain your own fork of the leap_web app. You can keep your customizations in that fork instead of in the provider `files/webapp` directory. Or, perhaps you want to add an engine to the application that modifies the app's behavior.

To deploy your own leap_web, modify the provider file `common.json`:

    {
      "sources": {
        "webapp": {
          "revision": "origin/develop",
          "source": "https://github.com/leapcode/leap_web",
          "type": "git"
        }
      }
    }

To target only particular environment, modify instead `common.ENV.json`, where ENV is the name of the environment.

See https://github.com/leapcode/leap_web/blob/develop/doc/DEVELOP.md for notes on getting started hacking on leap_web.

Known problems
---------------------------

* Client certificates are generated without a CSR. The problem is that this makes the web
  application extremely vulnerable to denial of service attacks. This was not an issue until we
  started to allow the possibility of anonymously fetching a client certificate without
  authenticating first.

* By its very nature, the user database is vulnerable to enumeration attacks. These are
  very hard to prevent, because our protocol is designed to allow query of a user database via
  proxy in order to provide network perspective.

