require "formula"

class RiscvGcc < Formula
  homepage "http://riscv.org"
  url "https://github.com/riscv/riscv-gnu-toolchain.git"

  bottle do
    root_url 'http://riscv.org.s3.amazonaws.com/bottles'
    rebuild 7
    sha256 "90db1f437b67fc08cfe7b53485586a092aa9c1b15e566f0da90f0fa6c89845c2" => :sierra
    sha256 "57cf04771aa27c181082b5f812f87d93974321f175088e1a4fb547823dd9f488" => :high_sierra
  end

  option "with-multilib", "Build with multilib support"

  depends_on "gawk" => :build
  depends_on "gnu-sed" => :build
  depends_on "gmp"
  depends_on "mpfr"
  depends_on "libmpc"
  depends_on "isl"

  # Fix parallel build on APFS filesystem
  # https://gcc.gnu.org/bugzilla/show_bug.cgi?id=81797
  if MacOS.version >= :high_sierra
    patch :DATA
  end

  def install
    # disable crazy flag additions
    ENV.delete 'CPATH'

    args = [
      "--prefix=#{prefix}",
      "--with-gmp=#{Formula["gmp"].opt_prefix}",
      "--with-mpfr=#{Formula["mpfr"].opt_prefix}",
      "--with-mpc=#{Formula["libmpc"].opt_prefix}",
      "--with-isl=#{Formula["isl"].opt_prefix}",
      "--with-system-zlib"
    ]
    args << "--enable-multilib" if build.with?("multilib")

    system "./configure", *args
    system "make"

    # don't install Python bindings if system already has them
    if File.exist?("#{HOMEBREW_PREFIX}/share/gcc-7.2.0")
      opoo "Not overwriting share/gcc-7.2.0"
      rm_rf "#{prefix}/share/gcc-7.2.0"
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
diff --git a/riscv-gcc/libstdc++-v3/include/Makefile.in b/riscv-gcc/libstdc++-v3/include/Makefile.in
index 783c647087f..5a6c8035067 100644
--- a/riscv-gcc/libstdc++-v3/include/Makefile.in
+++ b/riscv-gcc/libstdc++-v3/include/Makefile.in
@@ -1764,6 +1764,8 @@ ${pch3_output}: ${pch3_source} ${pch2_output}
 @GLIBCXX_HOSTED_TRUE@install-data-local: install-headers
 @GLIBCXX_HOSTED_FALSE@install-data-local: install-freestanding-headers
 
+.NOTPARALLEL: install-headers
+
 # This is a subset of the full install-headers rule.  We only need <ciso646>,
 # <cstddef>, <cfloat>, <limits>, <climits>, <cstdint>, <cstdlib>, <new>,
 # <typeinfo>, <exception>, <initializer_list>, <cstdalign>, <cstdarg>,
