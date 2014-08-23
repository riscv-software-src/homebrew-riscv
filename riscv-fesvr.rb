require "formula"

class RiscvFesvr < Formula
  homepage "http://riscv.org"
  url "https://github.com/ucb-bar/riscv-fesvr.git"

  # disable superenv to use brew installed gcc48
  env :std

  depends_on "homebrew/versions/gcc48"

  def install
    # using gcc48 from std env
    ENV.delete 'CFLAGS'
    ENV.delete 'LDFLAGS'
    ENV.delete 'CPPFLAGS'
    ENV.delete 'CXXFLAGS'
    ENV['CC'] = "gcc-4.8"
    ENV['CXX'] = "g++-4.8"

    system "mkdir", "build"
    cd "build" do
      system "../configure", "--prefix=#{prefix}"
      system "make", "prefix=#{HOMEBREW_PREFIX}", "CFLAGS=-DTARGET_ARCH=\"\""
      system "make", "install"
    end
  end

  test do
    system "false"
  end
end
