require "formula"

class RiscvIsaSim < Formula
  homepage "http://riscv.org"
  url "https://github.com/ucb-bar/riscv-isa-sim.git"

  bottle do
    revision 1
    root_url 'http://riscv.org.s3.amazonaws.com/bottles'
    cellar :any
    sha1 "c5618d39fffbbc506e2e7c8ee0cd49841e5e31ec" => :mavericks
  end

  depends_on "homebrew/versions/gcc48" => :build
  depends_on "riscv-fesvr"

  # disable superenv to use brew installed gcc48
  env :std

  def install
    # using gcc48 from std env
    ENV.delete 'CFLAGS'
    ENV.delete 'CXXFLAGS'
    ENV['CC'] = "gcc-4.8"
    ENV['CXX'] = "g++-4.8"

    system "mkdir", "build"
    cd "build" do
      system "../configure", "--prefix=#{prefix}"
      system "make", "install"
    end
  end

  test do
    system "false"
  end
end
