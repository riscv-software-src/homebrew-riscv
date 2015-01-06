require "formula"

class RiscvGcc < Formula
  homepage "http://riscv.org"
  url "https://github.com/ucb-bar/riscv-gnu-toolchain.git"

  bottle do
    root_url 'http://riscv.org.s3.amazonaws.com/bottles'
    revision 2
    sha1 "a96250e7b16e322537f2c3827bc25d730658eeba" => :yosemite
  end

  depends_on "gawk" => :build
  depends_on "gnu-sed" => :build
  depends_on "gmp"
  depends_on "mpfr"
  depends_on "libmpc"

  # disable superenv's flags
  env :std

  def install
    # disable crazy flag additions
    ENV.delete 'CFLAGS'
    ENV.delete 'CXXFLAGS'

    system "mkdir", "build"
    cd "build" do
      system "../configure", "--prefix=#{prefix}"
      system "make"
    end

    if File.exist?("#{HOMEBREW_PREFIX}/share/gcc-4.9.2/")
      system "rm", "-rf", "#{prefix}/share"
    end
  end

  test do
    system "false"
  end
end
