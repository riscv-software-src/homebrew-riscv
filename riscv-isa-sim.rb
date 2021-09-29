class RiscvIsaSim < Formula
  desc "RISC-V ISA simulator (spike)"
  homepage "http://riscv.org"
  url "https://github.com/riscv/riscv-isa-sim.git"
  version "master"

  bottle do
    root_url "http://riscv.org.s3.amazonaws.com/bottles"
    rebuild 7
    sha256 cellar: :any, big_sur: "bee17e6123195a92359c25f5c77a2d46d81e377f1a3820383c5ccb4499aa11db"
  end

  depends_on "dtc"
  depends_on "boost"

  patch :DATA

  def install
    mkdir "build"
    cd "build" do
      # configure uses --with-target to set TARGET_ARCH but homebrew formulas only provide "with"/"without" options
      system "../configure", "--prefix=#{prefix}", "--with-boost=#{Formula["boost"].prefix}"
      system "make"
      system "make", "install"
    end
  end

  test do
    system "false"
  end
end

__END__
diff --git a/configure b/configure
index 5445b30..6958d33 100755
--- a/configure
+++ b/configure
@@ -682,7 +682,6 @@ infodir
 docdir
 oldincludedir
 includedir
-runstatedir
 localstatedir
 sharedstatedir
 sysconfdir
@@ -773,7 +772,6 @@ datadir='${datarootdir}'
 sysconfdir='${prefix}/etc'
 sharedstatedir='${prefix}/com'
 localstatedir='${prefix}/var'
-runstatedir='${localstatedir}/run'
 includedir='${prefix}/include'
 oldincludedir='/usr/include'
 docdir='${datarootdir}/doc/${PACKAGE_TARNAME}'
@@ -1026,15 +1024,6 @@ do
   | -silent | --silent | --silen | --sile | --sil)
     silent=yes ;;
 
-  -runstatedir | --runstatedir | --runstatedi | --runstated \
-  | --runstate | --runstat | --runsta | --runst | --runs \
-  | --run | --ru | --r)
-    ac_prev=runstatedir ;;
-  -runstatedir=* | --runstatedir=* | --runstatedi=* | --runstated=* \
-  | --runstate=* | --runstat=* | --runsta=* | --runst=* | --runs=* \
-  | --run=* | --ru=* | --r=*)
-    runstatedir=$ac_optarg ;;
-
   -sbindir | --sbindir | --sbindi | --sbind | --sbin | --sbi | --sb)
     ac_prev=sbindir ;;
   -sbindir=* | --sbindir=* | --sbindi=* | --sbind=* | --sbin=* \
@@ -1172,7 +1161,7 @@ fi
 for ac_var in	exec_prefix prefix bindir sbindir libexecdir datarootdir \
 		datadir sysconfdir sharedstatedir localstatedir includedir \
 		oldincludedir docdir infodir htmldir dvidir pdfdir psdir \
-		libdir localedir mandir runstatedir
+		libdir localedir mandir
 do
   eval ac_val=\$$ac_var
   # Remove trailing slashes.
@@ -1325,7 +1314,6 @@ Fine tuning of the installation directories:
   --sysconfdir=DIR        read-only single-machine data [PREFIX/etc]
   --sharedstatedir=DIR    modifiable architecture-independent data [PREFIX/com]
   --localstatedir=DIR     modifiable single-machine data [PREFIX/var]
-  --runstatedir=DIR       modifiable per-process data [LOCALSTATEDIR/run]
   --libdir=DIR            object code libraries [EPREFIX/lib]
   --includedir=DIR        C header files [PREFIX/include]
   --oldincludedir=DIR     C header files for non-gcc [/usr/include]
@@ -4835,41 +4823,6 @@ fi
 done
 
 
-{ $as_echo "$as_me:${as_lineno-$LINENO}: checking whether C++ compiler accepts -relocatable-pch" >&5
-$as_echo_n "checking whether C++ compiler accepts -relocatable-pch... " >&6; }
-if ${ax_cv_check_cxxflags___relocatable_pch+:} false; then :
-  $as_echo_n "(cached) " >&6
-else
-
-  ax_check_save_flags=$CXXFLAGS
-  CXXFLAGS="$CXXFLAGS  -relocatable-pch"
-  cat confdefs.h - <<_ACEOF >conftest.$ac_ext
-/* end confdefs.h.  */
-
-int
-main ()
-{
-
-  ;
-  return 0;
-}
-_ACEOF
-if ac_fn_cxx_try_compile "$LINENO"; then :
-  ax_cv_check_cxxflags___relocatable_pch=yes
-else
-  ax_cv_check_cxxflags___relocatable_pch=no
-fi
-rm -f core conftest.err conftest.$ac_objext conftest.$ac_ext
-  CXXFLAGS=$ax_check_save_flags
-fi
-{ $as_echo "$as_me:${as_lineno-$LINENO}: result: $ax_cv_check_cxxflags___relocatable_pch" >&5
-$as_echo "$ax_cv_check_cxxflags___relocatable_pch" >&6; }
-if test "x$ax_cv_check_cxxflags___relocatable_pch" = xyes; then :
-  HAVE_CLANG_PCH=yes
-
-else
-  :
-fi
 
 
 #-------------------------------------------------------------------------
diff --git a/configure.ac b/configure.ac
index 13797a0..9560029 100644
--- a/configure.ac
+++ b/configure.ac
@@ -93,7 +93,7 @@ AC_CHECK_TYPE([__int128_t], AC_SUBST([HAVE_INT128],[yes]))
 
 AX_APPEND_LINK_FLAGS([-Wl,--export-dynamic])
 
-AX_CHECK_COMPILE_FLAG([-relocatable-pch], AC_SUBST([HAVE_CLANG_PCH],[yes]))
+AC_SUBST([HAVE_CLANG_PCH],[])
 
 #-------------------------------------------------------------------------
 # MCPPBS subproject list
