require "formula"

class RiscvIsaSim < Formula
  homepage "riscv.org"
  url "https://github.com/ucb-bar/riscv-isa-sim.git"
  sha1 ""

  # disable superenv to use brew installed gcc48
  env :std

  depends_on "homebrew/versions/gcc48"
  depends_on "riscv-fesvr"

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
