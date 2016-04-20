#!/bin/bash
set -ev

install_eigen3()
{
  cmake_args=${CMAKE_ARGS}
  CMAKE_ARGS="${CMAKE_ARGS} -Dpkg_config_libdir='${DEVEL_DIR}/install/lib'"
  install_tar_dependency "http://bitbucket.org/eigen/eigen/get/3.2.4.tar.bz2" "eigen-eigen-10219c95fe65" j
  CMAKE_ARGS=${cmake_args}
}

install_doxygen()
{
    _cd_src_directory
    echo "--> Installing Doxygen"
    wget --quiet -O - "ftp://ftp.stack.nl/pub/users/dimitri/doxygen-1.8.11.linux.bin.tar.gz" | tar -xz;
    cd "$build_dir/doxygen-1.8.11"
    ./configure --prefix "$DEVEL_DIR/install"
    {
      make $MAKE_ARGS install > ${MAKE_OUTPUTFILE}
    } || {
      :
    }
}

install_octomap()
{
  install_github_dependency OctoMap/octomap tags/v1.6.8
}
