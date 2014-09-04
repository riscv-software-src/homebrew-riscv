require "formula"

class RiscvPk < Formula
  homepage "http://riscv.org"
  url "https://github.com/ucb-bar/riscv-pk.git"

  bottle do
    root_url 'http://riscv.org.s3.amazonaws.com/bottles'
    cellar :any
    sha1 "3279999f44db854472fa0ff9dffe52105ff44474" => :mavericks
  end

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
