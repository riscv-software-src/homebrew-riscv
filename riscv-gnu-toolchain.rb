require "formula"

class RiscvGnuToolchain < Formula
  homepage "http://riscv.org"
  url "https://github.com/riscv/riscv-gnu-toolchain.git"

  bottle do
    root_url 'http://riscv.org.s3.amazonaws.com/bottles'
    rebuild 4
    sha256 "5230a0b7de452860a6377a48aca82e69394c7fd571645fa9460f54de209aeef4" => :mojave
    sha256 "aecb4b8733a792bd8770d548bc7a0deddc324576186e24b9bff5f6833390af54" => :high_sierra
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

    system "./configure", *args
    system "make"

    # don't install Python bindings if system already has them
    if File.exist?("#{HOMEBREW_PREFIX}/share/gcc-9.2.0")
      opoo "Not overwriting share/gcc-9.2.0"
      rm_rf "#{prefix}/share/gcc-9.2.0"
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
