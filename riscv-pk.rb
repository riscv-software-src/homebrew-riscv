require "formula"

class RiscvPk < Formula
  homepage "http://riscv.org"
  url "https://github.com/ucb-bar/riscv-pk.git"

  bottle do
    root_url 'http://riscv.org.s3.amazonaws.com/bottles'
    revision 2
    sha1 "d5634ea4b9314b3ccf8eaac09803abcd744781e2" => :yosemite
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
