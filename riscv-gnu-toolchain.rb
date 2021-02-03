require "formula"

class RiscvGnuToolchain < Formula
  homepage "http://riscv.org"
  url "https://github.com/riscv/riscv-gnu-toolchain.git"
  version "master"

  bottle do
    root_url 'http://riscv.org.s3.amazonaws.com/bottles'
    rebuild 3
    sha256 "2ee7eeaf5ae9a868e53da8aa5d9ccf47bb0de1d44a42d1f862602a9333e60aa5" => :catalina
  end

  option "with-multilib", "Build with multilib support"

  depends_on "gawk" => :build
  depends_on "gnu-sed" => :build
  depends_on "gmp"
  depends_on "mpfr"
  depends_on "libmpc"
  depends_on "isl"

  def install
    # disable crazy flag additions
    ENV.delete 'CPATH'

    args = [
      "--prefix=#{prefix}"
    ]
    args << "--enable-multilib" if build.with?("multilib")

    # Workaround for M1
    # See https://github.com/riscv/homebrew-riscv/issues/47
    system 'sed', '-i', '.bak', 's/.*=host-darwin.o$//', 'riscv-gcc/gcc/config.host'
    system 'sed', '-i', '.bak', 's/.* x-darwin.$//', 'riscv-gcc/gcc/config.host'

    system "./configure", *args
    system "make"

    # don't install Python bindings if system already has them
    if File.exist?("#{HOMEBREW_PREFIX}/share/gcc-10.2.0")
      opoo "Not overwriting share/gcc-10.2.0"
      rm_rf "#{prefix}/share/gcc-10.2.0"
    end

    # don't install gdb bindings if system already has them
    if File.exist?("#{HOMEBREW_PREFIX}/share/gdb")
      opoo "Not overwriting share/gdb"
      rm_rf "#{prefix}/share/gdb"
      rm "#{prefix}/share/info/annotate.info"
      rm "#{prefix}/share/info/gdb.info"
      rm "#{prefix}/share/info/stabs.info"
    end

    # don't install gdb includes if system already has them
    if File.exist?("#{HOMEBREW_PREFIX}/include/gdb")
      opoo "Not overwriting include/gdb"
      rm_rf "#{prefix}/include/gdb"
    end
  end

  test do
    system "false"
  end
end
