require "formula"

class RiscvFesvr < Formula
  homepage "http://riscv.org"
  url "https://github.com/riscv/riscv-fesvr.git"

  bottle do
    root_url 'http://riscv.org.s3.amazonaws.com/bottles'
    revision 5
    sha256 "315aabf533d8f1abda101b0915d12300ed6c3ca645bdee387bac4a26cd55bd16" => :yosemite
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
