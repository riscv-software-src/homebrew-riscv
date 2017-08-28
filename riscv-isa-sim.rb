require "formula"

class RiscvIsaSim < Formula
  homepage "http://riscv.org"
  url "https://github.com/riscv/riscv-isa-sim.git"

  bottle do
    root_url 'http://riscv.org.s3.amazonaws.com/bottles'
    sha256 "b1043f133eb4ea3e2dfaf67294130af5763850106e970be8741a5d7d4cd03b36" => :sierra
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
