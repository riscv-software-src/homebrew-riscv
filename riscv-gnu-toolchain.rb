# Avoids pulling in all submodules because so big, especially w/ recursive
class NoRecursiveGitDownloadStrategy < GitDownloadStrategy
  sig { params(timeout: T.nilable(Time)).void }
  def update(timeout: nil)
    config_repo
    update_repo(timeout: timeout)
    checkout(timeout: timeout)
    reset
    # update_submodules(timeout: timeout) if submodules?
  end

  sig { params(timeout: T.nilable(Time)).void }
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
    rebuild 15
    sha256 sonoma: "ef2e103e306aa3e4794d8bd5609618835e10260a44fe4502fe7d30beddf0f509"
    sha256 arm64_sonoma: "0131cce13fae8b9c40d48b2b7cee3682bf1def0430281a2af7f7f8569efb93ac"
  end

  # enabling multilib by default, must choose to build without
  option "with-NOmultilib", "Build WITHOUT multilib support"

  depends_on "gawk" => :build
  depends_on "gnu-sed" => :build
  depends_on "flock" => :build
  depends_on "texinfo" => :build
  depends_on "gmp"
  depends_on "isl"
  depends_on "libmpc"
  depends_on "mpfr"
  depends_on "zstd"

  def install
    # disable crazy flag additions
    ENV.delete "CPATH"

    # need to pull in needed submodules (now that they are disabled above)
    system "git", "submodule", "update", "--depth", "1", "--init", "--recursive", "newlib"
    system "git", "submodule", "update", "--depth", "1", "--init", "--recursive", "binutils"
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
    system "make"
    system "make", "build-qemu"

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
