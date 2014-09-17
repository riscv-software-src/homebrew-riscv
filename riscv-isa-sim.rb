require "formula"

class RiscvIsaSim < Formula
  homepage "http://riscv.org"
  url "https://github.com/ucb-bar/riscv-isa-sim.git"

  bottle do
    root_url 'http://riscv.org.s3.amazonaws.com/bottles'
    revision 2
    sha1 "bde9d412fcd1ebea00eabddf45e4fcfecc2724ef" => :mavericks
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
