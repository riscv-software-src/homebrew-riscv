require "formula"

class RiscvTools < Formula
  homepage "riscv.org"
  url "https://github.com/ucb-bar/riscv-tools/archive/master.zip"
  sha1 ""
  version "0.1"

  # install rest of tools
  depends_on "riscv-fesvr"
  depends_on "riscv-isa-sim"
  depends_on "riscv-gcc"
  depends_on "riscv-pk"

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! It's enough to just replace
    # "false" with the main program this formula installs, but it'd be nice if you
    # were more thorough. Run the test with `brew test riscv`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    system "false"
  end
end
