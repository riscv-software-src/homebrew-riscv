class RiscvPk < Formula
  desc "RISC-V Proxy Kernel"
  homepage "http://riscv.org"
  url "https://github.com/riscv/riscv-pk.git"
  version "main"

  bottle do
    root_url "http://riscv.org.s3.amazonaws.com/bottles"
    rebuild 17
    sha256 cellar: :any_skip_relocation, sonoma: "f5b94eebf17b92cb3f91d3f7f9ae1b7c1d78fcf93a33791de3e9b3bac11edecb"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "52de5cbc3eb258ae290d602cd85d2a868c94d5130a62304481c05fb15076f9c4"
  end

  depends_on "gnu-sed" => :build
  depends_on "riscv-gnu-toolchain" => :build
  depends_on "riscv-isa-sim" => :build

  def install
    # using riscv-gcc from std env
    ENV["CC"] = "riscv64-unknown-elf-gcc"

    mkdir "build"
    cd "build" do
      system "../configure", "--prefix=#{prefix}", "--host=riscv64-unknown-elf", \
        "--with-arch=rv64imafdc_zifencei"
      # Requires gnu-sed's behavior to build, and don't want to change -Wno-unused
      inreplace "Makefile", " sed", " gsed"
      system "make", "install"
    end
  end

  test do
    system "false"
  end
end
