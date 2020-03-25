require "formula"

class RiscvPk < Formula
  homepage "http://riscv.org"
  url "https://github.com/riscv/riscv-pk.git"
  version "master"

  bottle do
    root_url 'http://riscv.org.s3.amazonaws.com/bottles'
    cellar :any_skip_relocation
    sha256 "2c7e91b169bca977800ca1d14cd7f2fc7494b5729f3e18016fec73fbf832fed2" => :catalina
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
