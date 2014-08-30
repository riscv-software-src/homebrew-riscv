require "formula"

class RiscvGcc < Formula
  homepage "http://riscv.org"
  url "https://github.com/ucb-bar/riscv-gcc.git"

  bottle do
    root_url 'http://riscv.org/bottles'
    cellar :any
    sha1 "f03220f649daa03a8af80549bf4f1dee431a4e32" => :mavericks
  end

  depends_on "gawk" => :build
  depends_on "homebrew/versions/gcc48" => :build

  def install
    # disable superenv to use brew installed gcc48
    env :std

    # using gcc48 from std env
    ENV.delete 'CFLAGS'
    ENV.delete 'CXXFLAGS'
    ENV['CC'] = "gcc-4.8"
    ENV['CXX'] = "g++-4.8"

    system "mkdir", "build"
    cd "build" do
      system "../configure", "--prefix=#{prefix}"
      system "make"
    end
  end

  test do
    system "false"
  end
end
