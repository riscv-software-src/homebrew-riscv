require "formula"

class RiscvGcc < Formula
  homepage "http://riscv.org"
  url "https://github.com/ucb-bar/riscv-gnu-toolchain.git"

  bottle do
    root_url 'http://riscv.org.s3.amazonaws.com/bottles'
    revision 1
    sha1 "78a86189654a96e96a2bc2ef8611ee07dd23c842" => :mavericks
  end

  depends_on "gawk" => :build
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
  end

  test do
    system "false"
  end
end
