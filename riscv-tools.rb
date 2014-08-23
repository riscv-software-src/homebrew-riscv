require "formula"

class RiscvTools < Formula
  homepage "riscv.org"
  url "https://github.com/ucb-bar/riscv-tools/archive/master.zip"
  version "0.1"

  # install rest of tools
  depends_on "riscv-fesvr"
  depends_on "riscv-isa-sim"
  depends_on "riscv-gcc"
  depends_on "riscv-pk"

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
