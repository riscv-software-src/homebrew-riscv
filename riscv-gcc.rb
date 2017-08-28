require "formula"

class RiscvGcc < Formula
  homepage "http://riscv.org"
  url "https://github.com/riscv/riscv-gnu-toolchain.git"

  bottle do
    root_url 'http://riscv.org.s3.amazonaws.com/bottles'
    rebuild 4
    sha256 "f3fa6441a73a2987001f6f5a2aa079fba4e7a1c0e71cd4645a00fb455b576f49" => :sierra
  end

  option "with-multilib", "Build with multilib support"

  depends_on "gawk" => :build
  depends_on "gnu-sed" => :build
  depends_on "gmp"
  depends_on "mpfr"
  depends_on "libmpc"
  depends_on "isl"

  # disable superenv's flags
  env :std

  def install
    # disable crazy flag additions
    ENV.delete 'CFLAGS'
    ENV.delete 'CXXFLAGS'
    ENV.delete 'LD'

    args = ["--prefix=#{prefix}"]
    args << "--enable-multilib" if build.with?("multilib")
    mkdir "build"
    cd "build" do
      system "../configure", *args
      system "make"
    end

    # don't install Python bindings if system already has them
    if File.exist?("#{HOMEBREW_PREFIX}/share/gcc-7.1.1/")
      rm_rf "share/gcc-7.1.1"
    end

    # don't install gdb bindings if system already has them
    if File.exist?("#{HOMEBREW_PREFIX}/share/gdb/")
      rm_rf "share/gdb"
    end
  end

  test do
    system "false"
  end
end
