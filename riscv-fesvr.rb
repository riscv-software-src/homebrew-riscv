require "formula"

class RiscvFesvr < Formula
  homepage "http://riscv.org"
  url "https://github.com/ucb-bar/riscv-fesvr.git"

  bottle do
    revision 1
    root_url 'http://riscv.org.s3.amazonaws.com/bottles'
    cellar :any
    sha1 "f72f692520246f2c706acbf8528197681d33a8d9" => :mavericks
  end

  depends_on "homebrew/versions/gcc48" => :build

  # disable superenv to use brew installed gcc48
  env :std

  def install
    # using gcc48 from std env
    ENV.delete 'CFLAGS'
    ENV.delete 'LDFLAGS'
    ENV.delete 'CPPFLAGS'
    ENV.delete 'CXXFLAGS'
    ENV['CC'] = "gcc-4.8"
    ENV['CXX'] = "g++-4.8"
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
