RISC-V Toolchain [![Build Status](https://travis-ci.org/riscv/homebrew-riscv.svg?branch=master)](https://travis-ci.org/riscv/homebrew-riscv)
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

If you have macOS Big Sur (11), `riscv-tools` will be installed from precompiled binaries. If you do not have Big Sure (for x86), `riscv-tools` will be built from source. Note building from source will require approximately 6.5 GB for all of the source and intermediate build files. It builds with the default compiler (clang), but you can specify another compiler on the command line. For example:

    $ brew install --cc=gcc-10 riscv-tools


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

By default the toolchain only supports 64 bit RISC-V targets. To install a toolchain that supports both 64 bit and 32 bit:

    $ brew install riscv-gnu-toolchain --with-multilib
