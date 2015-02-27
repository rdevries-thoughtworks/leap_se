@title = 'Bitmask known issues'
@nav_title = 'Known issues'
@summary = 'Known issues in Bitmask.'
@toc = true

Here you can find documentation about known issues and potential work-arounds
in the current Leap Platform release.

No polkit agent available
-------------------------

To run Bitmask and the services correctly you need to have a running polkit
agent. If you don't have one you will get an error and won't be able to start
Bitmask.

The currently recognized polkit agents are:

| process name                          | Who uses it?                      |
|---------------------------------------|-----------------------------------|
| `polkit-gnome-authentication-agent-1` | Gnome                             |
| `polkit-kde-authentication-agent-1`   | KDE                               |
| `polkit-mate-authentication-agent-1`  | Mate                              |
| `lxpolkit`                            | LXDE                              |
| `gnome-shell`                         | Gnome shell                       |
| `fingerprint-polkit-agent`            | the `fingerprint-gui` package     |


If you have a different polkit agent running that it's not in theat list,
please report a bug so we can include in our checks.

You can get the list of running processes that match polkit with the following
command: `ps aux | grep -i polkit`.
Here is an example on my KDE desktop:

    ➜ ps aux | grep polkit
    root      1392  0.0  0.0 298972  6120 ?        Sl   Sep22   0:02 /usr/lib/policykit-1/polkitd --no-debug
    user      1702  0.0  0.0  12972   920 pts/16   S+   16:42   0:00 grep polkit
    user      3259  0.0  0.4 559764 38464 ?        Sl   Sep22   0:05 /usr/lib/kde4/libexec/polkit-kde-authentication-agent-1


Other Issues
------------

- You may get the error: "Unable to connect: Problem with provider" in
  situations when the problem is the network instead of the provider.
  See: https://leap.se/code/issues/4023

Mail issues
-----------

Note that email is not stable yet so this list may not be accurate.

- If you have received a big ammount of mails (tested with more than 400), you
  may experience that Thunderbird won't respond.

That problem does not happen if you have the client open and Thunderbird
loading mails while are reaching your inbox.


- Opening the same account from more than one box at the same time will
  possibly break your account.

- Managing a huge ammount of mails (e.g.: moving mails to a folder) will block
  the UI (see https://leap.se/code/issues/4837)


Key generation too slow?
========================

When you create a new mail account, the key generation may take a while. While
it is normal that takes approx. 5mins, on virtual machines sometimes takes a
very long time. As long as a 40min!.
Using one of this tricks/hacks that time can be reduced to <5min.

If you are just testing mail accounts and **do not worry about security** you can
use some tricks to generate the extra entropy needed to speed up the process.

1. Manually generate entropy

    Move the mouse, type stuff, browse the internet and local files, etc.

1. Use haveged

    Install the haveged package, most likely is available through your distro's
    package manager.

    See: http://www.issihosts.com/haveged/

1. Generate IO (may not work on SSDs)

        find / -type f -print0 2>&1 | xargs -0 cat &> /dev/null

If you want more information you can take a look at:
https://leap.se/code/issues/4656
