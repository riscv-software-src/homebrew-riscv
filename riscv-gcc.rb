require "formula"

class RiscvGcc < Formula
  homepage "http://riscv.org"
  url "https://github.com/riscv/riscv-gnu-toolchain.git"

  bottle do
    root_url 'http://riscv.org.s3.amazonaws.com/bottles'
    revision 5
    sha256 "47342f895b456ebaf8c90b442fd62a3346a61869757d4ae81f33fa9d9ac0a5f6" => :yosemite
  end

  depends_on "gawk" => :build
  depends_on "gnu-sed" => :build
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

    system "mkdir", "build"
    cd "build" do
      system "../configure", "--prefix=#{prefix}"
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
