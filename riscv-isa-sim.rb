require "formula"

class RiscvIsaSim < Formula
  homepage "http://riscv.org"
  url "https://github.com/riscv/riscv-isa-sim.git"

  bottle do
    root_url 'http://riscv.org.s3.amazonaws.com/bottles'
    rebuild 4
    sha256 "5ba837a7d3a81df4f2019ee445274092e939af434361bf475221a33e59f0d68a" => :sierra
    sha256 "1a7f30b8f1c87e108f2e1ab9b795f8580d3e5bc4cc051884c6d04ec278e6d049" => :high_sierra
  end

  depends_on "riscv-fesvr"
  depends_on "dtc"


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
