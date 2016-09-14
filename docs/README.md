The primary source of platform documentation lives in:

   pages/docs/platform

However, we would like to also include a static render of this in the
leap_platform source code.

So, this is a separate amber site just for the platform documentation.

To generate portable static pages:

    cd leap_se/docs/platform
    amber server
    cd /tmp
    wget --mirror --convert-links --adjust-extension --page-requisites http://localhost:8000

Copy to leap_platform:

    rm ~/dev/leap_platform/docs
    mv localhost:8000 ~/dev/leap_platform/docs
