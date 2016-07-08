require "formula"

class RiscvGcc < Formula
  homepage "http://riscv.org"
  url "https://github.com/riscv/riscv-gnu-toolchain.git"

  bottle do
    root_url 'http://riscv.org.s3.amazonaws.com/bottles'
    revision 2
    sha256 "fc63a7b0d599a35ebd7e334dad8fd3956cceb7ab48fd4a7766c20d28be92a9a5" => :el_capitan
  end

  option "with-multilib", "Build with multilib support"

  depends_on "gawk" => :build
  depends_on "gnu-sed" => :build
  depends_on "gmp"
  depends_on "mpfr"
  depends_on "libmpc"
  depends_on "isl"

  # disable superenv's flags
  env :std

  def install
    # disable crazy flag additions
    ENV.delete 'CFLAGS'
    ENV.delete 'CXXFLAGS'
    ENV.delete 'LD'

    args = ["--prefix=#{prefix}"]
    args << "--enable-multilib" if build.with?("multilib")
    mkdir "build"
    cd "build" do
      system "../configure", *args
      system "make"
    end

    # don't install Python bindings if system already has them
    if File.exist?("#{HOMEBREW_PREFIX}/share/gcc-6.1.0/")
      rm_rf share
    end
  end

  test do
    system "false"
  end
end
