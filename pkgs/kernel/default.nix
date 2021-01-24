{ stdenv, fetchurl, bison, ncurses, pkg-config, flex, openssl, elfutils, bc
, gawk, hostname, perl }:

stdenv.mkDerivation rec {
  pname = "kernel-wasmcloud";
  version = "5.10.10";
  src = fetchurl {
    url =
      "https://cdn.kernel.org/pub/linux/kernel/v5.x/linux-${version}.tar.xz";
    sha256 = "06fvgkrn9127xw9kly6l4ws3yv80q8xfqdzaam92lljim5pqdvb0";
  };
  buildInputs =
    [ bison ncurses pkg-config flex openssl elfutils bc gawk hostname perl ];
  makeFlags = [ "vmlinux" "-j12" ];

  patchPhase = ''
    cp ${./Kconfig} .config
    sed -i scripts/ld-version.sh -e "s|/usr/bin/awk|${gawk}/bin/awk|"
  '';

  installPhase = ''
    mkdir -p $out
    cp vmlinux $out/vmlinux
  '';
}
