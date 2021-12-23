class RiscvTools < Formula
  desc "RISC-V toolchain including gcc (with newlib), simulator (spike), and pk"
  homepage "http://riscv.org"
  url "https://github.com/riscv/riscv-tools/archive/homebrew.tar.gz"
  version "0.2"
  sha256 "cb919eb7cf11071c6d11c721a9e77893a2dbe9158466e444eb3dd8476a89b7b4"

  # install rest of tools
  depends_on "riscv-gnu-toolchain"
  depends_on "riscv-isa-sim"
  depends_on "riscv-pk"
  depends_on "riscv-openocd"

  def install
    prefix.install "build.common"
    # not needed, but used to prevent formula being marked as empty
  end

  test do
    ENV.delete "CPATH"
    hello = "hello"
    (testpath/"hello.c").write("#include <stdio.h>
int main() {
  printf(\"#{hello}\");
  return 0;
}")
    system "#{Formula["riscv-gnu-toolchain"].opt_prefix}/bin/riscv64-unknown-elf-gcc", (testpath/"hello.c")
    assert_equal "bbl loader\r\nhello", shell_output("spike #{Formula["riscv-pk"].opt_prefix}/bin/pk #{testpath}/a.out")
  end
end
