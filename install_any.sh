#!/bin/bash

if [ `uname` = "Darwin" ]; then
    # install for Mac
    sh install_mac.sh
elif [ `uname` = "Linux" ]; then
    # install for Linux
    echo "Linux is not supported."
else
    echo "Your platform ($(uname -a)) is not supported."
    exit 1
fi
