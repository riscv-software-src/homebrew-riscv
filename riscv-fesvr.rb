require "formula"

class RiscvFesvr < Formula
  homepage "http://riscv.org"
  url "https://github.com/riscv/riscv-fesvr.git"

  bottle do
    root_url 'http://riscv.org.s3.amazonaws.com/bottles'
    cellar :any
    rebuild 1
    sha256 "5400cf8f87841992b10b10cd37de40725efce57af3492434815b0e99e03de7a7" => :sierra
    sha256 "eb585e5f344770001ee4d74f8e35a0f30ecae3d82c284bd68a8f03b2ca17ba02" => :high_sierra
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
