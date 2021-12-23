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

  depends_on "gnu-sed" => :build
  depends_on "riscv-gnu-toolchain" => :build
  depends_on "riscv-isa-sim" => :build

  def install
    # using riscv-gcc from std env
    ENV["CC"] = "riscv64-unknown-elf-gcc"

    mkdir "build"
    cd "build" do
      if build.with("BExt")
        system "../configure", "--prefix=#{prefix}", "--host=riscv64-unknown-elf", "--with-arch=rv64imafdcb"
      elsif build.with("ZExt")
        system "../configure", "--prefix=#{prefix}", "--host=riscv64-unknown-elf", "--with-arch=rv64gc_zba_zbb_zbc_zbe_zbf_zbm_zbp_zbr_zbs_zbt"
      elsif build.with("KExt")
        system "../configure", "--prefix=#{prefix}", "--host=riscv64-unknown-elf", "--with-arch=rv64imafdck"
      elsif build.with?("NOVExt")
        system "../configure", "--prefix=#{prefix}", "--host=riscv64-unknown-elf", "--with-arch=rv64imafdc"
      else
        system "../configure", "--prefix=#{prefix}", "--host=riscv64-unknown-elf", "--with-arch=rv64imafdcv" 
      end
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
