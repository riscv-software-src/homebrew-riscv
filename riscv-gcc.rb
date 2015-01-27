require "formula"

class RiscvGcc < Formula
  homepage "http://riscv.org"
  url "https://github.com/ucb-bar/riscv-gnu-toolchain.git"

  bottle do
    root_url 'http://riscv.org.s3.amazonaws.com/bottles'
    revision 4
    sha1 "bc96963081bf976d370aabaf34167ce61e21e0a1" => :yosemite
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
    ENV.delete 'LD'

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
