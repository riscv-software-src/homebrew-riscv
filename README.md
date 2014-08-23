RISCV Toolchain
===============

This provides packages to easily install the [RISCV](riscv.org) toolchain on OS X using [Homebrew](brew.sh).


Installation
------------

First, install homebrew:

    $ ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"

Get this tap:

    $ brew tap ucb-bar/riscv

Build the toolchain:

    $ brew install riscv-tools

In addition to building `riscv-tools` this is will also add `homebrew/versions` as a tap and install gcc-4.8.
