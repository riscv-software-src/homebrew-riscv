require "formula"

class RiscvFesvr < Formula
  homepage "http://riscv.org"
  url "https://github.com/riscv/riscv-fesvr.git"

  bottle do
    root_url 'http://riscv.org.s3.amazonaws.com/bottles'
    cellar :any
    sha256 "0905317028486c6921331981a9ce9146623b4b3a46a7f5c940acc91e6422021a" => :high_sierra
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
