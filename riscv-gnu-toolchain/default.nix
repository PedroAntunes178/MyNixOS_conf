{
  pkgs ? import (fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/refs/tags/22.11.tar.gz";
    sha256 = "sha256:11w3wn2yjhaa5pv20gbfbirvjq6i3m7pqrq2msf0g7cv44vijwgw";
  }) {}
}:

pkgs.stdenv.mkDerivation rec {
  pname = "riscv-gnu-toolchain";
  version = "2022.11.23";

  src = pkgs.fetchFromGitHub {
    owner = "riscv-collab";
    repo = "/riscv-gnu-toolchain";
    rev = "refs/tags/${version}";
    sha256 = "sha256-5BWWbjQ65/tDpWmY9r+oA013OhVkjga8GCLK90ZXe5k=";
    deepClone = true;
  };

  buildInputs = builtins.attrValues { inherit (pkgs) 
    git 
    stdenv 
    binutils 
    cmake 
    pkgconfig 
    curl
    wget
    vsftpd
    # packages needed to build the toolchain.
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
    patchutils
    gcc
    zlib
    gperf 
    libtool 
    bc 
    libdeflate
    expat
    gnumake
    
    utillinux
    bash;
  };

  configurePhase = ''
    echo "HELLO $PWD"
    mkdir -p $out/opt/riscv
  '';

  buildPhase = ''
    ls -la /build/source
    ./configure --prefix=$out/opt/riscv --enable-multilib
    git submodule init /build/source/gcc
    make
    make linux
  '';

  installPhase = ''
    echo "Done!"
  '';

  meta = with pkgs.lib; {
    description = "This is the RISC-V C and C++ cross-compiler. It supports two build modes: a generic ELF/Newlib toolchain and a more sophisticated Linux-ELF/glibc toolchain.";
    homepage = "https://github.com/riscv-collab/riscv-gnu-toolchain";
    license = licenses.gpl2;
    maintainers = with maintainers; [  ];
    platforms = platforms.linux;
  };
}
