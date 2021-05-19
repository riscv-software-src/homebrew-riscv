class RiscvGnuToolchain < Formula
  desc "RISC-V Compiler GNU Toolchain using newlib"
  homepage "http://riscv.org"
  url "https://github.com/riscv/riscv-gnu-toolchain.git"
  version "master"

  bottle do
    root_url "http://riscv.org.s3.amazonaws.com/bottles"
    rebuild 4
    sha256 big_sur: "c0359a03d84a194e05125b8efcc1b4b155e4c04742b64992bd2f39b0ffab907a"
  end

  option "with-multilib", "Build with multilib support"

  depends_on "gawk" => :build
  depends_on "gnu-sed" => :build
  depends_on "gmp"
  depends_on "isl"
  depends_on "libmpc"
  depends_on "mpfr"

  def install
    # disable crazy flag additions
    ENV.delete "CPATH"

    args = [
      "--prefix=#{prefix}",
      "--with-cmodel=medany",
    ]
    args << "--enable-multilib" if build.with?("multilib")

    # Workaround for M1
    # See https://github.com/riscv/homebrew-riscv/issues/47
    system "sed", "-i", ".bak", "s/.*=host-darwin.o$//", "riscv-gcc/gcc/config.host"
    system "sed", "-i", ".bak", "s/.* x-darwin.$//", "riscv-gcc/gcc/config.host"

    system "./configure", *args
    system "make"

    # don't install Python bindings if system already has them
    if File.exist?("#{HOMEBREW_PREFIX}/share/gcc-10.2.0")
      opoo "Not overwriting share/gcc-10.2.0"
      rm_rf "#{share}/gcc-10.2.0"
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
