class RiscvIsaSim < Formula
  desc "RISC-V ISA simulator (spike)"
  homepage "http://riscv.org"
  url "https://github.com/riscv/riscv-isa-sim.git"
  version "master"

  bottle do
    root_url "http://riscv.org.s3.amazonaws.com/bottles"
    rebuild 7
    sha256 cellar: :any, big_sur: "bee17e6123195a92359c25f5c77a2d46d81e377f1a3820383c5ccb4499aa11db"
  end

  depends_on "dtc"

  def install
    mkdir "build"
    cd "build" do
      # configure uses --with-target to set TARGET_ARCH
      system "../configure", "--prefix=#{prefix}", "--with-target=\"\""
      system "make", "prefix=#{HOMEBREW_PREFIX}"
      system "make", "install"
    end
  end

  test do
    system "false"
  end
end
