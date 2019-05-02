require "formula"

class RiscvIsaSim < Formula
  homepage "http://riscv.org"
  url "https://github.com/riscv/riscv-isa-sim.git"

  bottle do
    root_url 'http://riscv.org.s3.amazonaws.com/bottles'
    rebuild 7
    sha256 "795b2244743502246236b8d47f9c9c2d675b213965bf0b4b65e5f7f7e5867275" => :mojave
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
