RISCV Toolchain
===============

This provides packages to install the [RISC-V](http://riscv.org) toolchain on OS X using [Homebrew](http://brew.sh).


Installation
------------

First, install homebrew:

    $ ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"

Get this tap:

    $ brew tap ucb-bar/riscv

Build the toolchain:

    $ brew install riscv-tools

In addition to building `riscv-tools` this is will also add `homebrew/versions` as a tap and install `gcc-4.8`.


Testing
-------

You can verify your install was successful by:

    $ brew test riscv-tools

This will compile and run a hello world, so it will use all the components ([riscv-fesvr](http://github.com/ucb-bar/riscv-fesvr), [riscv-isa-sim](http://github.com/ucb-bar/riscv-isa-sim), [riscv-pk](http://github.com/ucb-bar/riscv-pk), and [riscv-gcc](http://github.com/ucb-bar/riscv-gcc)).


Updating
--------

To pull in the latest version of a package, you can force a reinstall of a single package:

    $ brew reinstall riscv-fesvr
