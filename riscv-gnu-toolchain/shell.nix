let pkgs = import <nixpkgs> {};
in
with pkgs.stdenv;
with pkgs.stdenv.lib;
pkgs.mkShell {
  name = "riscv-shell";
  buildInputs = builtins.attrValues { inherit (pkgs)     
    stdenv 
    binutils 
    cmake 
    pkgconfig 
    curl 
    autoconf 
    automake 
    python3 
    libmpc 
    mpfr 
    gmp 
    gawk 
    bison 
    flex 
    texinfo 
    gperf 
    libtool 
    patchutils 
    bc 
    libdeflate
    expat
    gnumake

    utillinux
    bash;
  };

  hardeningDisable = [ "all" ];
}
