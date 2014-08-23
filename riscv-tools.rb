require "formula"

class RiscvTools < Formula
  homepage "http://riscv.org"
  url "https://github.com/ucb-bar/riscv-tools/archive/master.tar.gz"
  sha1 "36ed62664c5fb52d434c78cf851c42aae2d99cd7"
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
    (testpath/'hello.c').write('#include<stdio.h>
 int main() {
   printf("hi\n");
   return 0;
 }')
    system "#{HOMEBREW_PREFIX}/bin/riscv-gcc", (testpath/'hello.c')
    system "#{HOMEBREW_PREFIX}/bin/spike", "#{HOMEBREW_PREFIX}/bin/pk", (testpath/'a.out')
  end
end
