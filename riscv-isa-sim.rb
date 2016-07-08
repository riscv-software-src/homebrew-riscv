require "formula"

class RiscvIsaSim < Formula
  homepage "http://riscv.org"
  url "https://github.com/riscv/riscv-isa-sim.git"

  bottle do
    root_url 'http://riscv.org.s3.amazonaws.com/bottles'
    revision 2
    sha256 "33c9f120239e2e9675c67806bea5878c04a92c02914aba6fb244e2f6bf173052" => :el_capitan
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
