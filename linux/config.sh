#!/bin/bash

# Setup environment variables.
INSTALL_DIR="$DEVEL_DIR/install"
export LD_LIBRARY_PATH="$INSTALL_DIR/lib:/opt/ros/indigo/lib:$LD_LIBRARY_PATH"
export LD_LIBRARY_PATH="$INSTALL_DIR/lib/`dpkg-architecture -qDEB_BUILD_MULTIARCH`:$LD_LIBRARY_PATH"
