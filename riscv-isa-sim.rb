require "formula"

class RiscvIsaSim < Formula
  homepage "http://riscv.org"
  url "https://github.com/riscv/riscv-isa-sim.git"

  bottle do
    root_url 'http://riscv.org.s3.amazonaws.com/bottles'
    rebuild 6
    sha256 "431f03e8249bbeb0e72b43332671d679c52b164801ae121ee88ead0153b1d023" => :sierra
    rebuild 5
    sha256 "f1ad638fab628b31b877f6458c0d82826c9af56e9b22bb559d8801d9ebfa4e72" => :high_sierra
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
