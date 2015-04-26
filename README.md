LEAP Web Pages
==================================

This is the repository for the LEAP website at https://leap.se.

It is entirely static, but relies on a bunch of apache tricks for things like
language negotiation. A static website generator called `amber` is used to
render the source files into html files.

To submit changes, please fork this repo and issue pull requests on github.

For more information how to use `amber`, see:
https://github.com/leapcode/amber.

For now, there is no post-commit hook on this repo that automatically triggers
an update to the website. To deploy the current version:

    sudo gem install capistrano
    git clone https://leap.se/git/leap_se
    cd leap_se
    cap deploy

This will deploy directly from master branch of https://leap.se/git/leap_se
(in other words, local changes are not deployed).