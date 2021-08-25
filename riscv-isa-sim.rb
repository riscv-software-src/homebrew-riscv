class RiscvIsaSim < Formula
  desc "RISC-V ISA simulator (spike)"
  homepage "http://riscv.org"
  url "https://github.com/riscv/riscv-isa-sim.git"
  version "master"

  bottle do
    root_url "http://riscv.org.s3.amazonaws.com/bottles"
    rebuild 5
    sha256 cellar: :any, big_sur: "51adde23d1b677c3bcd556d5c649541c581f2f536eccef9578cc1513b6ccd1a6"
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
