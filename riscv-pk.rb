class RiscvPk < Formula
  desc "RISC-V Proxy Kernel"
  homepage "http://riscv.org"
  url "https://github.com/riscv/riscv-pk.git"
  version "main"

  bottle do
    root_url "http://riscv.org.s3.amazonaws.com/bottles"
    rebuild 18
    sha256 cellar: :any_skip_relocation, sequoia: "86d01def81622cf8814379dcc75df160bb25d1f142ce656c858b8739464daf0f"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "cb044e0bb08c99b0f7483d5e934f99117e9281497e21a1eb3c05cc57aa6e99a3"
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
