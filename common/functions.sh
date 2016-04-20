#!/bin/bash

# Variable that can be configured
: ${CMAKE_BUILD_TYPE=Release}
: ${CMAKE_BUILD_REL_DIRECTORY=build}
: ${CMAKE_ARGS="-DCMAKE_INSTALL_LIBDIR=lib -DCMAKE_INSTALL_PREFIX='${DEVEL_DIR}/install' -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}"}
: ${MAKE_ARGS="-s -j4"}
: ${MAKE_REDIRECT_STDERR=0}
: ${MAKE_OUTPUTFILE="${ROOT_DIR}/make.log"}
: ${GIT_QUIET="--quiet"}

# git commands
: ${git=/usr/bin/git}
: ${git_submodule="${git} submodule ${GIT_QUIET} update --init"}
: ${git_checkout="${git} checkout ${GIT_QUIET}"}
: ${git_clone="${git} clone ${GIT_QUIET}"}

# create build directory inside source folder and run cmake and make
_do_install()
{
  echo "--> Compiling $1"
  [ ! -d "${CMAKE_BUILD_REL_DIRECTORY}" ] && mkdir -p ${CMAKE_BUILD_REL_DIRECTORY}
  cd ${CMAKE_BUILD_REL_DIRECTORY}
  cmake ${CMAKE_ARGS} ..
  if [ "${MAKE_REDIRECT_STDERR}" -eq "0" ]; then
    make ${MAKE_ARGS} install >> ${MAKE_OUTPUTFILE}
  else
    make ${MAKE_ARGS} install >> ${MAKE_OUTPUTFILE} 2>&1
  fi
}
_cd_src_directory()
{
  [ ! -d "${DEVEL_DIR}/src" ] && mkdir -p "${DEVEL_DIR}/src"
  cd "${DEVEL_DIR}/src"
}

# Install from tar
# 3 mandatory options: url, extracted directory name, tar options (most importantly, the compression type if any. x will be prepended)
# For instance:
# install_tar_dependency "https://github.com/roboptim/roboptim-core/releases/download/v3.1/roboptim-core-3.1.tar.bz2" "roboptim-core-3.1" "j"
install_tar_dependency()
{
  url=$1
  directory=$2
  _cd_src_directory
  wget --quiet -O - "$url" | tar x$3;
  cd "$directory"
  _do_install "$directory"
}


# Git dependency
install_git_dependency()
{
  url=$1
  directory=$2
  branch=$3
  _cd_src_directory
  $git_clone "$url" "$directory"
  cd "$directory"
  ${git_checkout} $branch
  ${git_submodule}
  _do_install "$directory"
}

install_github_dependency()
{
  url=https://github.com/$1
  branch=$2
  install_git_dependency $url $1 $branch
}
