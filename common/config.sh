#!/bin/bash

INSTALL_DIR="$DEVEL_DIR/install"

# Setup environment variables.
export LD_LIBRARY_PATH="$INSTALL_DIR/lib:/opt/ros/indigo/lib:$LD_LIBRARY_PATH"
export LD_LIBRARY_PATH="$INSTALL_DIR/lib/`dpkg-architecture -qDEB_BUILD_MULTIARCH`:$LD_LIBRARY_PATH"

export PKG_CONFIG_PATH="$INSTALL_DIR/lib/pkgconfig:/opt/ros/indigo/lib/pkgconfig:$PKG_CONFIG_PATH"
export PKG_CONFIG_PATH="$INSTALL_DIR/lib/`dpkg-architecture -qDEB_BUILD_MULTIARCH`/pkgconfig:$PKG_CONFIG_PATH"

export PATH=$DEVEL_DIR/install/sbin:$DEVEL_DIR/install/bin:$PATH

export PYTHONPATH=$DEVEL_DIR/install/lib/python2.7/site-packages:$DEVEL_DIR/install/lib/python2.7/dist-packages:/opt/ros/indigo/lib/python2.7/dist-packages:$PYTHONPATH

if [ -f $DEVEL_DIR/install/setup.bash ]; then
  source $DEVEL_DIR/install/setup.bash
elif [ -f /opt/ros/indigo/setup.bash ]; then
  source /opt/ros/indigo/setup.bash
fi
