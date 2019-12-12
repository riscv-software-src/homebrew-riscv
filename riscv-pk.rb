require "formula"

class RiscvPk < Formula
  homepage "http://riscv.org"
  url "https://github.com/riscv/riscv-pk.git"

  bottle do
    root_url 'http://riscv.org.s3.amazonaws.com/bottles'
    cellar :any_skip_relocation
    rebuild 7
    sha256 "86e7e866abbee132e439885d7a1bf9137b705756ba240c152ab3c2c93f8e8614" => :mojave
    sha256 "17253ca1c82f91ad4f805f8f04aeb8b33b7c6db2c5123a420c4971cd4edfb597" => :high_sierra
  end

  depends_on "riscv-isa-sim" => :build
  depends_on "riscv-gcc" => :build
  depends_on "gnu-sed" => :build

  def install
    # using riscv-gcc from std env
    ENV['CC'] = "riscv64-unknown-elf-gcc"

    mkdir "build"
    cd "build" do
      system "../configure", "--prefix=#{prefix}", "--host=riscv64-unknown-elf"
      # Requires gnu-sed's behavior to build, and don't want to change -Wno-unused
      inreplace "Makefile", " sed", " gsed"
      system "make", "install"
    end
    prefix.install Dir["#{prefix}/riscv64-unknown-elf/*"]
  end

  test do
    system "false"
  end
end
