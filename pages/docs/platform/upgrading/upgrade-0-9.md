@title = 'Upgrade to 0.9'
@toc = false


Upgrading to Platform 0.9
---------------------------------------------

You will need the new version of leap_cli:

    workstation$ sudo gem install leap_cli --version=1.9

If you don't want to install using 'sudo':

    workstation$ gem install --user-install leap_cli --version=1.9
    workstation$ PATH="$PATH:$(ruby -e 'puts Gem.user_dir')/bin"

Because 0.9 does not use submodules anymore, you must remove them before pulling
the latest leap_platform from git:

    workstation$ cd leap_platform
    workstation$ for dir in $(git submodule | awk '{print $2}'); do
    workstation$   git submodule deinit $dir
    workstation$ done
    workstation$ git pull
    workstation$ git checkout 0.9.0

Alternately, just clone a fresh leap_platform:

    workstation$ git clone https://leap.se/git/leap_platform
    workstation$ cd leap_platform
    workstation$ git checkout 0.9.0

Then, just deploy

    workstation$ cd PROVIDER_DIR
    workstation$ leap deploy

Known issues
---------------------------------------------

When upgrading, sometimes systemd does not report the correct state of a daemon.
The daemon will be not running, but systemd thinks it is. The symptom of this is
that a deploy will succeed but `leap test` will fail. To fix, you can run
`systemctl stop DAEMON` and then `systemctl start DAEMON` on the affected host
(systemctl restart seems to work less reliably).