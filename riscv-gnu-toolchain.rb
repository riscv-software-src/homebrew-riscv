class RiscvGnuToolchain < Formula
  desc "RISC-V Compiler GNU Toolchain using newlib"
  homepage "http://riscv.org"
  url "https://github.com/riscv/riscv-gnu-toolchain.git"
  version "master"

  bottle do
    root_url "http://riscv.org.s3.amazonaws.com/bottles"
    rebuild 7
    sha256 big_sur: "ff79aa9252e2636007a22e780389d0e5fa3bf0eb81a0df5e2b6d4ca74a6d851e"
  end

  # enabling multilib by default, must choose to build without
  option "with-NOmultilib", "Build WITHOUT multilib support"
  option "with-NOVExt", "Build WITHOUT V Extension"
  option "with-ZExt", "Build WITHOUT Z Extension"
  option "with-KExt", "Build WITHOUT K Extension"
  option "with-BExt", "Build WITHOUT B Extension"

  depends_on "gawk" => :build
  depends_on "gnu-sed" => :build
  depends_on "gmp"
  depends_on "isl"
  depends_on "libmpc"
  depends_on "mpfr"
  depends_on "zstd"

  def install
    # disable crazy flag additions
    ENV.delete "CPATH"

    args = [
      "--prefix=#{prefix}",
      "--with-cmodel=medany",
    ]
    args << "--enable-multilib" unless build.with?("NOmultilib")

    args << "--with-arch=rv64imafdcb" if build.with?("BExt")
    system "cd riscv-gcc/ && git remote add pz9115 https://github.com/pz9115/riscv-gcc.git && git fetch pz9115 && git checkout riscv-gcc-10.2.0-rvb && cd ../riscv-binutils && git remote add pz9115 https://github.com/pz9115/riscv-binutils-gdb.git && git fetch pz9115 && git checkout riscv-binutils-experiment && cd .." if build.with?("BExt")

    args << "--with-arch=rv64gc_zba_zbb_zbc_zbe_zbf_zbm_zbp_zbr_zbs_zbt --with-abi=lp64 --with-multilib-generator='rv64gc_zba_zbb_zbc_zbe_zbf_zbm_zbp_zbr_zbs_zbt-lp64--'" if build.with?("ZExt")
    system "cd riscv-gcc/ && git remote add pz9115 https://github.com/pz9115/riscv-gcc.git && git fetch pz9115 && git checkout riscv-gcc-10.2.0-rvb && cd ../riscv-binutils && git remote add pz9115 https://github.com/pz9115/riscv-binutils-gdb.git && git fetch pz9115 && git checkout riscv-binutils-experiment && cd .." if build.with?("ZExt")

    args << "--with-arch=rv64imafdck" if build.with?("KExt")
    system "cd riscv-gcc/ && git remote add wsy https://github.com/WuSiYu/riscv-gcc.git && git fetch wsy && git checkout riscv-gcc-10.2.0-crypto && cd ../riscv-binutils && git remote add pz9115 https://github.com/pz9115/riscv-binutils-gdb.git && git fetch pz9115 && git checkout riscv-binutils-2.36-k-ext && cd .." if build.with?("KExt")

    args << "--with-arch=rv64imafdc" if build.with?("NOVExt")

    args << "--with-abi=lp64d --with-multilib-generator='rv64gcv-lp64d--' --with-arch=rv64imafdcv" unless build.with?("NOVExt")
    system "cd riscv-gcc/ && git fetch origin && git checkout riscv-gcc-10.1-rvv-dev && cd ../riscv-binutils && git fetch origin && git checkout rvv-1.0.x && cd .." unless build.with?("NOVExt")

    # Workaround for M1
    # See https://github.com/riscv/homebrew-riscv/issues/47
    system "sed", "-i", ".bak", "s/.*=host-darwin.o$//", "riscv-gcc/gcc/config.host"
    system "sed", "-i", ".bak", "s/.* x-darwin.$//", "riscv-gcc/gcc/config.host"
    
    system "./configure", *args
    system "make"

    # don't install Python bindings if system already has them
    if File.exist?("#{HOMEBREW_PREFIX}/share/gcc-11.1.0")
      opoo "Not overwriting share/gcc-11.1.0"
      rm_rf "#{share}/gcc-11.1.0"
    end

    # don't install gdb bindings if system already has them
    if File.exist?("#{HOMEBREW_PREFIX}/share/gdb")
      opoo "Not overwriting share/gdb"
      rm_rf "#{share}/gdb"
      rm "#{share}/info/annotate.info"
      rm "#{share}/info/gdb.info"
      rm "#{share}/info/stabs.info"
    end

    # don't install gdb includes if system already has them
    if File.exist?("#{HOMEBREW_PREFIX}/include/gdb")
      opoo "Not overwriting include/gdb"
      rm_rf "#{include}/gdb"
    end
  end

  test do
    system "false"
  end
end
