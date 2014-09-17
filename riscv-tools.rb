require "formula"

class RiscvTools < Formula
  homepage "http://riscv.org"
  url "https://github.com/ucb-bar/riscv-tools/archive/homebrew.tar.gz"
  sha1 "e119bc4a4bf1de5a87aeec5bdfe6179591b53b80"
  version "0.1"

  # install rest of tools
  depends_on "riscv-fesvr"
  depends_on "riscv-isa-sim"
  depends_on "riscv-gcc"
  depends_on "riscv-pk"

  def install
    # dummy because done by dependences
  end

  test do
    hello = "hello"
    (testpath/'hello.c').write("#include <stdio.h>
int main() {
  printf(\"#{hello}\");
  return 0;
}")
    system "riscv-gcc", (testpath/'hello.c')
    assert_equal hello, shell_output("spike pk #{testpath}/a.out")
  end
end
