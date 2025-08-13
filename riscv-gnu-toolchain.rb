# Avoids pulling in all submodules because so big, especially w/ recursive
class NoRecursiveGitDownloadStrategy < GitDownloadStrategy
  sig { override.params(timeout: T.nilable(Time)).void }
  def update(timeout: nil)
    config_repo
    update_repo(timeout: timeout)
    checkout(timeout: timeout)
    reset
    # update_submodules(timeout: timeout) if submodules?
  end

  sig { override.params(timeout: T.nilable(Time)).void }
  def clone_repo(timeout: nil)
    command! "git", args: clone_args, timeout: timeout&.remaining

    command! "git",
             args:    ["config", "homebrew.cacheversion", cache_version],
             chdir:   cached_location,
             timeout: timeout&.remaining
    checkout(timeout: timeout)
    # update_submodules(timeout: timeout) if submodules?
  end
end

class RiscvGnuToolchain < Formula
  desc "RISC-V Compiler GNU Toolchain using newlib"
  homepage "http://riscv.org"
  url "https://github.com/riscv/riscv-gnu-toolchain.git", :using => NoRecursiveGitDownloadStrategy
  version "main"

  bottle do
    root_url "http://riscv.org.s3.amazonaws.com/bottles"
    rebuild 17
    sha256 sonoma: "dadf0b051e4be1061d76ff758c907467eb92112f77ccaeadc44c9f746c582884"
    sha256 arm64_sequoia: "95917aa644e53aba86f8d6e840e281e4cb8b782153e5c6e3fd5788f19a572ada"
  end

  # enabling multilib by default, must choose to build without
  option "with-NOmultilib", "Build WITHOUT multilib support"

  depends_on "gawk" => :build
  depends_on "gnu-sed" => :build
  depends_on "make" => :build
  depends_on "flock" => :build
  depends_on "texinfo" => :build
  depends_on "gettext"
  depends_on "gmp"
  depends_on "isl"
  depends_on "libmpc"
  depends_on "mpfr"
  depends_on "zstd"

  # patch zlib to compile on newer macOS. remove when zlib >= 1.3.1
  def patch
    system "git", "submodule", "update", "--depth", "1", "--init", "--recursive", "binutils"
    system "patch", "-p1", "-i", Pathname(__dir__) / "zlib-fix.patch"
  end

  def install
    # disable crazy flag additions
    ENV.delete "CPATH"

    # need to pull in needed submodules (now that they are disabled above)
    system "git", "submodule", "update", "--depth", "1", "--init", "--recursive", "newlib"
    system "git", "submodule", "update", "--depth", "1", "--init", "--recursive", "gcc"

    args = [
      "--prefix=#{prefix}",
      "--with-cmodel=medany",
      "--disable-gdb"
    ]
    args << "--enable-multilib" unless build.with?("NOmultilib")

    # Workaround for M1
    # See https://github.com/riscv/homebrew-riscv/issues/47
    # 2024-01-11 Commenting out because no longer needed?
    # system "sed", "-i", ".bak", "s/.*=host-darwin.o$//", "gcc/gcc/config.host"
    # system "sed", "-i", ".bak", "s/.* x-darwin.$//", "gcc/gcc/config.host"

    system "./configure", *args
    system "gmake"

    # don't install gdb bindings if system already has them
    if File.exist?("#{HOMEBREW_PREFIX}/share/gdb")
      opoo "Not overwriting share/gdb"
      rm_rf "#{share}/gdb"
    end
    
    # don't install info if system already has them
    if File.exist?("#{HOMEBREW_PREFIX}/share/info")
      opoo "Not overwriting share/info"
      rm_rf "#{share}/info"
    end

    # don't install gdb includes if system already has them
    if File.exist?("#{HOMEBREW_PREFIX}/include/gdb")
      opoo "Not overwriting include/gdb"
      rm_rf "#{include}/gdb"
    end
  end

  test do
    system "false"
  end
end
