require "formula"

class RiscvIsaSim < Formula
  homepage "http://riscv.org"
  url "https://github.com/riscv/riscv-isa-sim.git"

  bottle do
    root_url 'http://riscv.org.s3.amazonaws.com/bottles'
    rebuild 8
    sha256 "26929b901717fdbdcf1e92f84e3bf1a29b4f1b7a24f15b66c80aad957f10e9ba" => :mojave
    sha256 "dac3adfd69c26c8ff9af507c204feb2ce50f23d2220550228245f54cbd29a0ba" => :high_sierra
  end

  depends_on "dtc"


  def install
    # this + prefixes below help spike find pk after being installed
    ENV['CXXFLAGS'] = "-DTARGET_ARCH=\"\""

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
