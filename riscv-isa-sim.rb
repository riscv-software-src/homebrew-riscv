require "formula"

class RiscvIsaSim < Formula
  homepage "http://riscv.org"
  url "https://github.com/ucb-bar/riscv-isa-sim.git"

  bottle do
    root_url 'http://riscv.org/bottles'
    cellar :any
    sha1 "ff860e553813af73f575ce4705aa4101b91615a7" => :mavericks
  end

  depends_on "homebrew/versions/gcc48" => :build
  depends_on "riscv-fesvr"

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
      system "make", "install"
    end
  end

  test do
    system "false"
  end
end
