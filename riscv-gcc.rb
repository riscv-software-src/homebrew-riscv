require "formula"

class RiscvGcc < Formula
  homepage "http://riscv.org"
  url "https://github.com/riscv/riscv-gnu-toolchain.git"

  bottle do
    root_url 'http://riscv.org.s3.amazonaws.com/bottles'
    sha256 "298c6e1aa03980000f1df7f6ed635192d67c25644460c571342ee8c05e3622a3" => :sierra
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
      rm_rf share
    end
  end

  test do
    system "false"
  end
end
