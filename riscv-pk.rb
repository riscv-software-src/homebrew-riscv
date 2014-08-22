require "formula"

class RiscvPk < Formula
  homepage "riscv.org"
  url "https://github.com/ucb-bar/riscv-pk.git"
  sha1 ""

  # disable superenv to use brew installed gcc48
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
      system "make", "install" # if this fails, try separate make/make install steps
    end
  end

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
