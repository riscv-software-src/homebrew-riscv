class RiscvIsaSim < Formula
  desc "RISC-V ISA simulator (spike)"
  homepage "http://riscv.org"
  url "https://github.com/riscv/riscv-isa-sim.git"
  version "master"

  bottle do
    root_url "http://riscv.org.s3.amazonaws.com/bottles"
    rebuild 3
    sha256 cellar: :any, big_sur: "1829a5b84295baa8688f8682987b1b653e911ba00597d69a3ca2f32ebf5c54b3"
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
