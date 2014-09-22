require "formula"

class RiscvIsaSim < Formula
  homepage "http://riscv.org"
  url "https://github.com/ucb-bar/riscv-isa-sim.git"

  bottle do
    root_url 'http://riscv.org.s3.amazonaws.com/bottles'
    revision 3
    sha1 "25fe3fa9ebaa40880bf85ee35ad606fc57b40110" => :mavericks
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
