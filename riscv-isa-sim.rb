class RiscvIsaSim < Formula
  desc "RISC-V ISA simulator (spike)"
  homepage "http://riscv.org"
  url "https://github.com/riscv/riscv-isa-sim.git"
  version "master"

  bottle do
    root_url "http://riscv.org.s3.amazonaws.com/bottles"
    rebuild 4
    sha256 cellar: :any, big_sur: "45fdca77e6f263ab5814be272ee259ee1efd1759873d01a831d84b9a05d522d1"
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
