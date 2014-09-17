require "formula"

class RiscvGcc < Formula
  homepage "http://riscv.org"
  url "https://github.com/ucb-bar/riscv-gnu-toolchain.git"

  bottle do
    root_url 'http://riscv.org.s3.amazonaws.com/bottles'
    cellar :any
    sha1 "f03220f649daa03a8af80549bf4f1dee431a4e32" => :mavericks
  end

  depends_on "gawk" => :build
  depends_on "gmp" => :build
  depends_on "mpfr" => :build
  depends_on "libmpc" => :build

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
