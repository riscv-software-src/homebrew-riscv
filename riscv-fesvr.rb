require "formula"

class RiscvFesvr < Formula
  homepage "http://riscv.org"
  url "https://github.com/ucb-bar/riscv-fesvr.git"

  bottle do
    root_url 'http://riscv.org.s3.amazonaws.com/bottles'
    revision 3
    sha1 "5abd1f7b22bf1106c956e5480dc2fd2cc605ed71" => :yosemite
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
