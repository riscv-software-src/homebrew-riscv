RISC-V Toolchain [![Build Status](https://github.com/riscv/homebrew-riscv/actions/workflows/macos-ci.yml/badge.svg)](https://github.com/riscv/homebrew-riscv/actions/workflows/macos-ci.yml)
================

This provides packages to install the [RISC-V](http://riscv.org) toolchain on OS X using [Homebrew](http://brew.sh).


Installation
------------

First, install homebrew:

    $ /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

Get this tap:

    $ brew tap riscv/riscv

Build the toolchain:

    $ brew install riscv-tools

If you have macOS Big Sur (11), `riscv-tools` will be installed from precompiled binaries. If you do not have Big Sur (for x86), `riscv-tools` will be built from source. Note building from source will require approximately 6.5 GB for all of the source and intermediate build files. It builds with the default compiler (clang), but you can specify another compiler on the command line. For example:

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
