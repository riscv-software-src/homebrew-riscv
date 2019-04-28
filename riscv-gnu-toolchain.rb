require "formula"

class RiscvGnuToolchain < Formula
  homepage "http://riscv.org"
  url "https://github.com/riscv/riscv-gnu-toolchain.git"

  bottle do
    root_url 'http://riscv.org.s3.amazonaws.com/bottles'
    rebuild 3
    sha256 "ab88fa01b569f727f3adae5945149aec6168b8325c99cd7458ffe6a7b30f2936" => :mojave
    sha256 "7ad0750aa6ba26e4ea2109aade784af6d79066638da1846f373b3c24ebcdff70" => :high_sierra
  end

  option "with-multilib", "Build with multilib support"

  depends_on "gawk" => :build
  depends_on "gnu-sed" => :build
  depends_on "gmp"
  depends_on "mpfr"
  depends_on "libmpc"
  depends_on "isl"

  def install
    # disable crazy flag additions
    ENV.delete 'CPATH'

    args = [
      "--prefix=#{prefix}"
    ]
    args << "--enable-multilib" if build.with?("multilib")

    system "./configure", *args
    system "make"

    # don't install Python bindings if system already has them
    if File.exist?("#{HOMEBREW_PREFIX}/share/gcc-8.2.0")
      opoo "Not overwriting share/gcc-8.2.0"
      rm_rf "#{prefix}/share/gcc-8.2.0"
    end

    # don't install gdb bindings if system already has them
    if File.exist?("#{HOMEBREW_PREFIX}/share/gdb")
      opoo "Not overwriting share/gdb"
      rm_rf "#{prefix}/share/gdb"
      rm "#{prefix}/share/info/annotate.info"
      rm "#{prefix}/share/info/gdb.info"
      rm "#{prefix}/share/info/stabs.info"
    end

    # don't install gdb includes if system already has them
    if File.exist?("#{HOMEBREW_PREFIX}/include/gdb")
      opoo "Not overwriting include/gdb"
      rm_rf "#{prefix}/include/gdb"
    end
  end

  test do
    system "false"
  end
end

__END__
