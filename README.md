RISC-V Toolchain [![Build Status](https://github.com/riscv/homebrew-riscv/actions/workflows/macos-ci.yml/badge.svg)](https://github.com/riscv/homebrew-riscv/actions/workflows/macos-ci.yml)
================

This provides packages to install the [RISC-V](http://riscv.org) toolchain on macOS using [Homebrew](http://brew.sh).


Installation
------------

First, install homebrew:

    $ /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

Get this tap:

    $ brew tap riscv-software-src/homebrew-riscv

Build the toolchain:

    $ brew install riscv-tools

If you have macOS Sonoma (14), `riscv-tools` will be installed from precompiled binaries. If you do not have Ventura, `riscv-tools` will be built from source. Note building from source will require approximately 6.5 GB for all of the source and intermediate build files. It builds with the default compiler (clang), but you can specify another compiler on the command line. For example:

    $ brew install --cc=gcc-10 riscv-tools

Due to high number of dependences the RISC-V version of OpenOCD is not installed by default. If needed, it can be installed with:

    $ brew install riscv-openocd

Testing
-------

You can verify your install was successful by:

    $ brew test riscv-tools

This will compile and run a hello world, so it will use all of the components ([riscv-isa-sim](http://github.com/riscv/riscv-isa-sim), [riscv-pk](http://github.com/riscv/riscv-pk), and [riscv-gnu-toolchain](http://github.com/riscv/riscv-gnu-toolchain)).


Updating
--------

To pull in the latest version of a package, you can force an install and compile it yourself by:

    $ brew reinstall --build-from-source riscv-gnu-toolchain

Supporting 32 bit Targets
-------------------------

By default the toolchain will enable multilib with support for 32 bit targets. To disable multilib to speed up build times and save space:

    $ brew install riscv-gnu-toolchain --with-NOmultilib


Troubleshooting
---------------
To support organizational changes, we have had to make the following two naming changes which may cause issues for existing users. It can often be simplest to remove everything (uninstall with `brew remove`, and untap with `brew untap riscv/riscv`) and then to re-install (directions up top). 

* `riscv` -> `riscv-software-src` (for organization) - As long as GitHub continues to redirect the URL, this has not caused problems.
* `master` -> `main` (for default branch name) - GitHub's branch redirection can be problematic. If you don't want to reinstall, you may be able to fix your tap with the following:
```
$> cd `brew --repository`/Library/Taps/riscv-software-src/homebrew-riscv
$> git branch -m master main
$> git fetch origin
$> git branch -u origin/main main
$> git remote set-head origin -a
```
