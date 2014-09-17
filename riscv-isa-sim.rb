require "formula"

class RiscvIsaSim < Formula
  homepage "http://riscv.org"
  url "https://github.com/ucb-bar/riscv-isa-sim.git"

  bottle do
    revision 1
    root_url 'http://riscv.org.s3.amazonaws.com/bottles'
    cellar :any
    sha1 "c5618d39fffbbc506e2e7c8ee0cd49841e5e31ec" => :mavericks
  end

  depends_on "riscv-fesvr"


  def install
    system "mkdir", "build"
    cd "build" do
      system "../configure", "--prefix=#{prefix}"
      system "make", "install"
    end
  end

  test do
    system "false"
  end
end
