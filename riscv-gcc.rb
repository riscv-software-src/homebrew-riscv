require "formula"

class RiscvGcc < Formula
  homepage "http://riscv.org"
  url "https://github.com/riscv/riscv-gnu-toolchain.git"

  bottle do
    root_url 'http://riscv.org.s3.amazonaws.com/bottles'
    sha256 "bd580ee568dd37be861a9a8b5b81204b77865d195b82e605ca641508111de7d5" => :yosemite
  end

  option "with-multilib", "Build with multilib support"

  depends_on "gawk" => :build
  depends_on "gnu-sed" => :build
  depends_on "cloog018"
  depends_on "gmp"
  depends_on "mpfr"
  depends_on "libmpc"

  # disable superenv's flags
  env :std

  def install
    # disable crazy flag additions
    ENV.delete 'CFLAGS'
    ENV.delete 'CXXFLAGS'
    ENV.delete 'LD'

    args = ["--prefix=#{prefix}"]
    args << "--enable-multilib" if build.with?("multilib")
    system "mkdir", "build"
    cd "build" do
      system "../configure", *args
      system "make"
    end

    if File.exist?("#{HOMEBREW_PREFIX}/share/gcc-5.2.0/")
      system "rm", "-rf", "#{prefix}/share"
    end
  end

  test do
    system "false"
  end
end
