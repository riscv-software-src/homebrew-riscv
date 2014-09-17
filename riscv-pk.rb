require "formula"

class RiscvPk < Formula
  homepage "http://riscv.org"
  url "https://github.com/ucb-bar/riscv-pk.git"

  bottle do
    root_url 'http://riscv.org.s3.amazonaws.com/bottles'
    revision 1
    sha1 "7d5b7c3b7dd7f01f3477a05e1841de16f87b9568" => :mavericks
  end

  depends_on "riscv-isa-sim" => :build
  depends_on "riscv-gcc" => :build

  # disable superenv to use brew installed riscv-gcc
  env :std

  def install
    # using riscv-gcc from std env
    ENV.delete 'CFLAGS'
    ENV.delete 'LDFLAGS'
    ENV['CC'] = "riscv-gcc"

    system "mkdir", "build"
    cd "build" do
      system "../configure", "--prefix=#{prefix}", "--host=riscv"
      system "make", "install"
    end
  end

  test do
    system "false"
  end
end
