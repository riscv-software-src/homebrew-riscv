class RiscvIsaSim < Formula
  desc "RISC-V ISA simulator (spike)"
  homepage "http://riscv.org"
  url "https://github.com/riscv/riscv-isa-sim.git"
  version "main"

  bottle do
    root_url "http://riscv.org.s3.amazonaws.com/bottles"
    rebuild 21
    sha256 cellar: :any, sequoia: "9664e9c8307c1734e406a7ea9373d8d6df2453c0b24ced3b6be4284c7b8f66e5"
    sha256 cellar: :any, arm64_sequoia: "6400dbf446a68666afdd532b0d04f7b5164ae27e9bcce40a1ed78adbc029a553"
  end

  depends_on "dtc"
  depends_on "boost" => :optional

  opoo "Building with clang could fail due to upstream bug: https://github.com/riscv-software-src/riscv-isa-sim/issues/820" if build.with? "boost"

  def install
    mkdir "build"
    cd "build" do
      args = [
        "--prefix=#{prefix}", "--with-target=Cellar/riscv-pk/main/riscv64-unknown-elf"
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
