require "formula"

class RiscvIsaSim < Formula
  homepage "http://riscv.org"
  url "https://github.com/ucb-bar/riscv-isa-sim.git"

  bottle do
    root_url 'http://riscv.org.s3.amazonaws.com/bottles'
    revision 4
    sha1 "94e4a749e91050151b1e1c1b011dd3f6d7f5d50e" => :yosemite
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
