class RiscvIsaSim < Formula
  desc "RISC-V ISA simulator (spike)"
  homepage "http://riscv.org"
  url "https://github.com/riscv/riscv-isa-sim.git"
  version "master"

  bottle do
    root_url "http://riscv.org.s3.amazonaws.com/bottles"
    rebuild 6
    sha256 cellar: :any, big_sur: "a9e6583bc4b0bb0ed928933b746cb9d3738b2dfdaae7defa17721ec7b3550bd5"
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
