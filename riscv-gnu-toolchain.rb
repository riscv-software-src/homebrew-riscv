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
    rebuild 13
    sha256 ventura: "bc5339e65688bbe7e77953daa63cc681fbd6df3a8a1f75d6e0f1d904751e0d83"
  end

  # enabling multilib by default, must choose to build without
  option "with-NOmultilib", "Build WITHOUT multilib support"
  option "with-enable-rvv", "Workaround to enable RISCV Vector Extension"

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

    args = [
      "--prefix=#{prefix}",
      "--with-cmodel=medany",
    ]
    args << "--enable-multilib" unless build.with?("NOmultilib")

    if build.with?("enable-rvv")
      puts "Enable RISCV Vector Extension"
      system "git", "clone", "https://github.com/gcc-mirror/gcc", "-b", "releases/gcc-13", "gcc-13"
      current_path = `pwd`.chomp
      args << "--with-gcc-src="+current_path+"/gcc-13"
    end

    # need to pull in needed submodules (now that they are disabled above)
    system "git", "submodule", "update", "--init", "--recursive", "newlib"
    system "git", "submodule", "update", "--init", "--recursive", "binutils"
    unless build.with?("enable-rvv")
      system "git", "submodule", "update", "--init", "--recursive", "gcc"
    end

    # Workaround for M1
    # See https://github.com/riscv/homebrew-riscv/issues/47
    if build.with?("enable-rvv")
      system "sed", "-i", ".bak", "s/.*=host-darwin.o$//", "gcc-13/gcc/config.host"
      system "sed", "-i", ".bak", "s/.* x-darwin.$//", "gcc-13/gcc/config.host"
    else
      system "sed", "-i", ".bak", "s/.*=host-darwin.o$//", "gcc/gcc/config.host"
      system "sed", "-i", ".bak", "s/.* x-darwin.$//", "gcc/gcc/config.host"
    end

    system "./configure", *args
    system "make"

    # don't install Python bindings if system already has them
    if File.exist?("#{HOMEBREW_PREFIX}/share/gcc-11.1.0")
      opoo "Not overwriting share/gcc-11.1.0"
      rm_rf "#{share}/gcc-11.1.0"
    end

    # don't install gdb bindings if system already has them
    if File.exist?("#{HOMEBREW_PREFIX}/share/gdb")
      opoo "Not overwriting share/gdb"
      rm_rf "#{share}/gdb"
      rm "#{share}/info/annotate.info"
      rm "#{share}/info/gdb.info"
      rm "#{share}/info/stabs.info"
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
