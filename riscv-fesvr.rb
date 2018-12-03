require "formula"

class RiscvFesvr < Formula
  homepage "http://riscv.org"
  url "https://github.com/riscv/riscv-fesvr.git"

  bottle do
    root_url 'http://riscv.org.s3.amazonaws.com/bottles'
    cellar :any
    rebuild 1
    sha256 "8af6a3159a02a8600a0e86533794d6ec759d34f1b380382865147318eb85f9d3" => :mojave
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
