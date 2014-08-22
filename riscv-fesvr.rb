require "formula"

class RiscvFesvr < Formula
  homepage "riscv.org"
  url "https://github.com/ucb-bar/riscv-fesvr.git"
  sha1 ""

  # disable superenv to use brew installed gcc48
  env :std

  depends_on "gcc48"

  def install
    # using gcc48 from std env
    ENV.delete 'CFLAGS'
    ENV.delete 'LDFLAGS'
    ENV.delete 'CPPFLAGS'
    ENV.delete 'CXXFLAGS'
    ENV['CC'] = "gcc-4.8"
    ENV['CXX'] = "g++-4.8"
    # ENV['CFLAGS'] = "-DTARGET_ARCH"

    system "mkdir", "build"
    cd "build" do
      system "../configure", "--prefix=#{prefix}"
      # system "fdgfdfd"
      system "make", "prefix=#{HOMEBREW_PREFIX}", "CFLAGS=-DTARGET_ARCH=\"\""
      system "make", "install" # if this fails, try separate make/make installsteps
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
