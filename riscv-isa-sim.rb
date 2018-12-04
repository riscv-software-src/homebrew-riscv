require "formula"

class RiscvIsaSim < Formula
  homepage "http://riscv.org"
  url "https://github.com/riscv/riscv-isa-sim.git"

  bottle do
    root_url 'http://riscv.org.s3.amazonaws.com/bottles'
    rebuild 1
    sha256 "795b2244743502246236b8d47f9c9c2d675b213965bf0b4b65e5f7f7e5867275" => :mojave
    rebuild 6
    sha256 "43b5e9fa752fcbda827a0803c91f6599ecc88967d2ffd44b7207baa2ca90fabd" => :high_sierra
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
