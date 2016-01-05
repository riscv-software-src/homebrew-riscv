RISC-V Toolchain [![Build Status](https://travis-ci.org/riscv/homebrew-riscv.svg?branch=master)](https://travis-ci.org/riscv/homebrew-riscv)
================

This provides packages to install the [RISC-V](http://riscv.org) toolchain on OS X using [Homebrew](http://brew.sh).


Installation
------------

First, install homebrew:

    $ ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"

Get this tap:

    $ brew tap riscv/riscv

Build the toolchain:

    $ brew install riscv-tools

If you have OS X El Capitan (10.11), `riscv-tools` will be installed from precompiled binaries. If you do not have El Capitan, `riscv-tools` will be built from source. It builds with the default compiler (clang), but you can specify another compiler on the command line. For example:

    $ brew install --cc=gcc-5 riscv-tools


Testing
-------

You can verify your install was successful by:

    $ brew test riscv-tools

This will compile and run a hello world, so it will use all of the components ([riscv-fesvr](http://github.com/riscv/riscv-fesvr), [riscv-isa-sim](http://github.com/riscv/riscv-isa-sim), [riscv-pk](http://github.com/riscv/riscv-pk), and [riscv-gcc](http://github.com/riscv/riscv-gcc)).


Updating
--------

To pull in the latest version of a package, you can force an install and compile it yourself by:

    $ brew reinstall --build-from-source riscv-fesvr
