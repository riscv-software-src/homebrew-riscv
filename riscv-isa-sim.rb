require "formula"

class RiscvIsaSim < Formula
  homepage "http://riscv.org"
  url "https://github.com/riscv/riscv-isa-sim.git"

  bottle do
    root_url 'http://riscv.org.s3.amazonaws.com/bottles'
    rebuild 7
    sha256 "370093bbc74f739ea0f0d90389ab29112501afe66a4b728178fabb22be92a320" => :mojave
    sha256 "6ba9cadda5b2c99ce5b6550a0b7e8abd12a346ed1ffc965008e8d3042376bb1a" => :high_sierra
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
