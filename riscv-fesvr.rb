require "formula"

class RiscvFesvr < Formula
  homepage "http://riscv.org"
  url "https://github.com/riscv/riscv-fesvr.git"

  bottle do
    root_url 'http://riscv.org.s3.amazonaws.com/bottles'
    cellar :any
    rebuild 2
    sha256 "e6f3047aa571d98eb6007a9cc224da62609793fb5934301e17d62f951262b39d" => :high_sierra
  end


  def install
    ENV['CXXFLAGS'] = "-DTARGET_ARCH=\"\""

    mkdir "build"
    cd "build" do
      system "../configure", "--prefix=#{prefix}"
      system "make", "prefix=#{HOMEBREW_PREFIX}"
      system "make", "install"
    end
  end

  test do
    system "false"
  end
end
