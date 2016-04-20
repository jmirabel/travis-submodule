#!/bin/bash
set -ev

install_eigen3()
{
  cmake_args=${CMAKE_ARGS}
  CMAKE_ARGS="${CMAKE_ARGS} -Dpkg_config_libdir='${DEVEL_DIR}/install/lib'"
  install_tar_dependency "http://bitbucket.org/eigen/eigen/get/3.2.4.tar.bz2" "eigen-eigen-10219c95fe65" j
  CMAKE_ARGS=${cmake_args}
}

install_octomap()
{
  install_github_dependency OctoMap/octomap tags/v1.6.8
}
