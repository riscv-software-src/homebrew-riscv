require "formula"

class RiscvIsaSim < Formula
  homepage "http://riscv.org"
  url "https://github.com/riscv/riscv-isa-sim.git"

  bottle do
    root_url 'http://riscv.org.s3.amazonaws.com/bottles'
    sha256 "563ec97535c4d60a477d7c5a5e58f300f0331ba48a05e29f06719fbd6b91d9ca" => :high_sierra
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
