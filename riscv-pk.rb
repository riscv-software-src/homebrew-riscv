require "formula"

class RiscvPk < Formula
  homepage "http://riscv.org"
  url "https://github.com/ucb-bar/riscv-pk.git"

  bottle do
    root_url 'http://riscv.org.s3.amazonaws.com/bottles'
    revision 3
    sha1 "a8b27539f68962f0319caf8c60adbaf33c5555ab" => :yosemite
  end

  depends_on "riscv-isa-sim" => :build
  depends_on "riscv-gcc" => :build

  # disable superenv to use brew installed riscv-gcc
  env :std

  def install
    # using riscv-gcc from std env
    ENV.delete 'CFLAGS'
    ENV.delete 'LDFLAGS'
    ENV['CC'] = "riscv64-unknown-elf-gcc"

    system "mkdir", "build"
    cd "build" do
      system "../configure", "--prefix=#{prefix}", "--host=riscv64-unknown-elf"
      system "make", "install"
    end
  end

  test do
    system "false"
  end
end
