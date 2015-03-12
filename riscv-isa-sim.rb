require "formula"

class RiscvIsaSim < Formula
  homepage "http://riscv.org"
  url "https://github.com/riscv/riscv-isa-sim.git"

  bottle do
    root_url 'http://riscv.org.s3.amazonaws.com/bottles'
    revision 7
    sha256 "c8d51666d92801c9eaab9711871646267a3c68fc9652655f40713ff8fcb31fdf" => :yosemite
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
