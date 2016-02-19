require "formula"

class RiscvPk < Formula
  homepage "http://riscv.org"
  url "https://github.com/riscv/riscv-pk.git"

  bottle do
    root_url 'http://riscv.org.s3.amazonaws.com/bottles'
    revision 1
    sha256 "869eede9d8cf0dc02f9cddc2c7ed42325c629018c5c7ed152377dfaf1307c71a" => :el_capitan
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

    mkdir "build"
    cd "build" do
      system "../configure", "--prefix=#{prefix}", "--host=riscv64-unknown-elf"
      system "make", "install"
    end
  end

  test do
    system "false"
  end
end
