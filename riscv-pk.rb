class RiscvPk < Formula
  desc "RISC-V Proxy Kernel"
  homepage "http://riscv.org"
  url "https://github.com/riscv/riscv-pk.git"
  version "master"

  bottle do
    root_url "http://riscv.org.s3.amazonaws.com/bottles"
    rebuild 6
    sha256 cellar: :any_skip_relocation, big_sur: "b81907fd0b41da4436b5255c4ff0135d67c55dc4ca174420f637ef7603841fd6"
  end
  option "with-NOmultilib", "Build WITHOUT multilib support"
  depends_on "gnu-sed" => :build
  depends_on "riscv-gnu-toolchain" => :build
  depends_on "riscv-isa-sim" => :build

  def install
    # using riscv-gcc from std env
    ENV["CC"] = "riscv64-unknown-elf-gcc" if build.with?("unless")
    ENV["CC"] = "riscv64-unknown-elf-gcc  -mabi=ilp32 -march=rv32imafdcv " unless build.with?("unless")

    mkdir "build"
    cd "build" do
      system "../configure", "--prefix=#{prefix}", "--host=riscv64-unknown-elf", "--with-arch=rv64imafdcv" if build.with?("NOmultilib")
      system "../configure", "--prefix=#{prefix}", "--host=riscv32-unknown-elf", "--with-arch=rv32imafdcv" unless build.with?("NOmultilib")
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
