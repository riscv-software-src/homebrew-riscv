class RiscvIsaSim < Formula
  desc "RISC-V ISA simulator (spike)"
  homepage "http://riscv.org"
  url "https://github.com/riscv/riscv-isa-sim.git"
  version "master"

  bottle do
    root_url "http://riscv.org.s3.amazonaws.com/bottles"
    rebuild 8
    sha256 cellar: :any, big_sur: "04b32b3e3b59e517d895dd8d32352a41d9413888135b256e9d8e22a3c172559c"
  end

  depends_on "dtc"
  depends_on "boost" => :optional

  opoo "Building with clang could fail due to upstream bug: https://github.com/riscv-software-src/riscv-isa-sim/issues/820" if build.with? "boost"

  def install
    mkdir "build"
    cd "build" do
      args = [
        "--prefix=#{prefix}", "--with-target=../../riscv-pk/master/riscv64-unknown-elf"
      ]
      if build.with? "boost"
        # This seems to be needed at least on macos/arm64
        args << "--with-boost=#{Formula["boost"].prefix}"
      else
        args << "--without-boost"
        args << "--without-boost-asio"
        args << "--without-boost-regex"
      end
      # configure uses --with-target to set TARGET_ARCH but homebrew formulas only provide "with"/"without" options
      system "../configure", *args 
      system "make"
      system "make", "install"
    end
  end

  test do
    system "false"
  end
end
