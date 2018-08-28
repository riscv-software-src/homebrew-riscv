require "formula"

class RiscvGnuToolchain < Formula
  homepage "http://riscv.org"
  url "https://github.com/riscv/riscv-gnu-toolchain.git"

  bottle do
    root_url 'http://riscv.org.s3.amazonaws.com/bottles'
    rebuild 2
    sha256 "4ebcc93a3a1f56b7e466dbc584702b84ad1a5baa6ba698df0753242eacccef18" => :sierra
    rebuild 1
    sha256 "315ea0024238989fea565835dbc6ea45dd702ad02391073c53ced7168be83e8f" => :high_sierra
  end

  option "with-multilib", "Build with multilib support"

  depends_on "gawk" => :build
  depends_on "gnu-sed" => :build
  depends_on "gmp"
  depends_on "mpfr"
  depends_on "libmpc"
  depends_on "isl"

  # isl 0.20 compatibility
  # https://gcc.gnu.org/bugzilla/show_bug.cgi?id=86724
  patch :DATA

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
diff --git a/riscv-gcc/gcc/graphite.h b/riscv-gcc/gcc/graphite.h
index 4e0e58c..be0a22b 100644
--- a/riscv-gcc/gcc/graphite.h
+++ b/riscv-gcc/gcc/graphite.h
@@ -37,6 +37,8 @@ along with GCC; see the file COPYING3.  If not see
 #include <isl/schedule.h>
 #include <isl/ast_build.h>
 #include <isl/schedule_node.h>
+#include <isl/id.h>
+#include <isl/space.h>

 typedef struct poly_dr *poly_dr_p;
