require "formula"

class RiscvPk < Formula
  homepage "http://riscv.org"
  url "https://github.com/riscv/riscv-pk.git"

  bottle do
    root_url 'http://riscv.org.s3.amazonaws.com/bottles'
    revision 4
    sha256 "4668401a947237d9572b6457a2a35c8e582ccf4e680ec5092117c8f19230cb1b" => :yosemite
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
