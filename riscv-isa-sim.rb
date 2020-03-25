require "formula"

class RiscvIsaSim < Formula
  homepage "http://riscv.org"
  url "https://github.com/riscv/riscv-isa-sim.git"
  version "master"

  bottle do
    root_url 'http://riscv.org.s3.amazonaws.com/bottles'
    cellar :any
    sha256 "208e7fd3d576620b37300b2167a349f126ebe0120f7994ecd3bf6ed3c204aeaa" => :catalina
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
