require "formula"

class RiscvFesvr < Formula
  homepage "http://riscv.org"
  url "https://github.com/riscv/riscv-fesvr.git"

  bottle do
    root_url 'http://riscv.org.s3.amazonaws.com/bottles'
    revision 4
    sha1 "5ea3d208f9fd342caf7044d7201c50687b0995bb" => :yosemite
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
