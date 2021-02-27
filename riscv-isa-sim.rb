class RiscvIsaSim < Formula
  desc "RISC-V ISA simulator (spike)"
  homepage "http://riscv.org"
  url "https://github.com/riscv/riscv-isa-sim.git"
  version "master"

  bottle do
    root_url "http://riscv.org.s3.amazonaws.com/bottles"
    rebuild 2
    sha256 cellar: :any, catalina: "7da66a93ee6bd2c9e40f1d0f6753ca6ebeea851eef51aab43f041ad2046bd893"
  end

  depends_on "dtc"

  def install
    # this + prefixes below help spike find pk after being installed
    ENV["CXXFLAGS"] = "-DTARGET_ARCH=\"\""

    mkdir "build"
    cd "build" do
      system "../configure", "--prefix=#{prefix}"
      system "make", "prefix=#{HOMEBREW_PREFIX}"
      system "make", "install"
    end
  end

  test do
    system "false"
  end
end
