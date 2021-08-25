class RiscvGnuToolchain < Formula
  desc "RISC-V Compiler GNU Toolchain using newlib"
  homepage "http://riscv.org"
  url "https://github.com/riscv/riscv-gnu-toolchain.git"
  version "master"

  bottle do
    root_url "http://riscv.org.s3.amazonaws.com/bottles"
    rebuild 5
    sha256 big_sur: "9215a88e36c8f69d8503ca568cb73fc9df8cbe50a982671d1b7a25f4cb0b496e"
  end

  # enabling multilib by default, must choose to build without
  option "with-NOmultilib", "Build WITHOUT multilib support"

  depends_on "gawk" => :build
  depends_on "gnu-sed" => :build
  depends_on "gmp"
  depends_on "isl"
  depends_on "libmpc"
  depends_on "mpfr"

  def install
    # disable crazy flag additions
    ENV.delete "CPATH"

    args = [
      "--prefix=#{prefix}",
      "--with-cmodel=medany",
    ]
    args << "--enable-multilib" unless build.with?("NOmultilib")

    # Workaround for M1
    # See https://github.com/riscv/homebrew-riscv/issues/47
    system "sed", "-i", ".bak", "s/.*=host-darwin.o$//", "riscv-gcc/gcc/config.host"
    system "sed", "-i", ".bak", "s/.* x-darwin.$//", "riscv-gcc/gcc/config.host"

    system "./configure", *args
    system "make"

    # don't install Python bindings if system already has them
    if File.exist?("#{HOMEBREW_PREFIX}/share/gcc-11.1.0")
      opoo "Not overwriting share/gcc-11.1.0"
      rm_rf "#{share}/gcc-11.1.0"
    end

    # don't install gdb bindings if system already has them
    if File.exist?("#{HOMEBREW_PREFIX}/share/gdb")
      opoo "Not overwriting share/gdb"
      rm_rf "#{share}/gdb"
      rm "#{share}/info/annotate.info"
      rm "#{share}/info/gdb.info"
      rm "#{share}/info/stabs.info"
    end

    # don't install gdb includes if system already has them
    if File.exist?("#{HOMEBREW_PREFIX}/include/gdb")
      opoo "Not overwriting include/gdb"
      rm_rf "#{include}/gdb"
    end
  end

  test do
    system "false"
  end
end
