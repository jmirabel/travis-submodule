# travis-submodule
Travis submodule for HPP

Copyright 2016 LAAS-CNRS

Author: Joseph Mirabel

## How to

#### Basic usage
Add this repository as a submodule and copy travis.TEMPLATE.yml:
```bash
git submodule add git://github.com/jmirabel/travis-submodule.git .travis-submodule
cp .travis-submodule/travis.TEMPLATE.yml .travis.yml
```
Open `.travis.yml` and follow the instructions in the comments.

#### Add external dependencies
If you want to add external dependencies not installed by apt on linux or homebrew on OSX,
you have 2 possibilities:
- update this module. This is the prefered way if you have to do it for other repositories as well.
 The method is:
  - if the installation is the same on linux and osx, add a function called `install_<packagename>` it to `common/dependencies.sh`
  - if installation is different on linux and osx, add a function called `install_<packagename>` in `osx/install` and in `linux/install`
- run a script in the `install` section of `.travis.yml` before `${TRAVIS_SUBMODULE}/install`.
