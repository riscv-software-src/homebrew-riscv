require "formula"

class RiscvFesvr < Formula
  homepage "http://riscv.org"
  url "https://github.com/ucb-bar/riscv-fesvr.git"

  bottle do
    root_url 'http://riscv.org.s3.amazonaws.com/bottles'
    revision 2
    sha1 "984865a10f790308a94c4a54409f38f5bd9243a6" => :mavericks
  end


  def install
    ENV['CXXFLAGS'] = "-DTARGET_ARCH=\"\""

    system "mkdir", "build"
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
