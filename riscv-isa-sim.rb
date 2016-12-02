require "formula"

class RiscvIsaSim < Formula
  homepage "http://riscv.org"
  url "https://github.com/riscv/riscv-isa-sim.git"

  bottle do
    root_url 'http://riscv.org.s3.amazonaws.com/bottles'
    rebuild 3
    sha256 "1a4d2da739bc1826069a72a25e7bbc86b2125bfc3dfdf8513da153716e24b101" => :sierra
  end

  depends_on "riscv-fesvr"


  def install
    mkdir "build"
    cd "build" do
      system "../configure", "--prefix=#{prefix}"
      system "make", "install"
    end
  end

  test do
    system "false"
  end
end
