require "formula"

class RiscvPk < Formula
  homepage "riscv.org"
  url "https://github.com/ucb-bar/riscv-pk.git"
  sha1 ""

  # disable superenv to use brew installed riscv-gcc
  env :std

  depends_on "riscv-gcc"

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
