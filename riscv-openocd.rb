class RiscvOpenocd < Formula
  desc "Fork of OpenOCD with RISC-V support"
  homepage "https://github.com/riscv/riscv-openocd.git"
  #head "https://github.com/riscv/riscv-openocd.git", branch: "riscv"
  url "https://github.com/riscv/riscv-openocd.git", branch: "riscv"
  version "riscv"

  keg_only "it conflicts with `openocd`"

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "texinfo" => :build
  depends_on "pkg-config" => :build

  depends_on "capstone"
  depends_on "hidapi"
  depends_on "libftdi"
  depends_on "libusb"
  depends_on "libusb-compat"

  def install
    system "./bootstrap", "nosubmodule"
    system "./configure", *std_configure_args, "--disable-silent-rules","--with-arch=rv64imafdcb" if build.with?("BExt")
    system "./configure", *std_configure_args, "--disable-silent-rules","--with-arch=rv64gc_zba_zbb_zbc_zbe_zbf_zbm_zbp_zbr_zbs_zbt" if build.with?("ZExt")
    system "./configure", *std_configure_args, "--disable-silent-rules","--with-arch=rv64imafdck" if build.with?("KExt")
    system "./configure", *std_configure_args, "--disable-silent-rules","--with-arch=rv64imafdc" if build.with?("NOVExt")
    system "./configure", *std_configure_args, "--disable-silent-rules","--with-arch=rv64imafdcv" unless build.with?("NOVExt")

    system "make", "install"
  end

  test do
    system "false"
  end
end
