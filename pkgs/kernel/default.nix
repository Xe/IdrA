{ stdenv, fetchurl, bison, ncurses, pkg-config, flex, openssl, elfutils, bc
, gawk, hostname, perl }:

stdenv.mkDerivation rec {
  pname = "kernel-wasmcloud";
  version = "5.8.1";
  src = fetchurl {
    url =
      "https://cdn.kernel.org/pub/linux/kernel/v5.x/linux-${version}.tar.xz";
    sha256 = "09574qbcrncb34dx9pd65iqs06758zim4nkncnjzmxwgjgza9lpq";
  };
  buildInputs =
    [ bison ncurses pkg-config flex openssl elfutils bc gawk hostname perl ];
  makeFlags = [ "vmlinux" ];

  patchPhase = ''
    cp ${./Kconfig} .config
    sed -i scripts/ld-version.sh -e "s|/usr/bin/awk|${gawk}/bin/awk|"
  '';

  installPhase = ''
    mkdir -p $out
    cp vmlinux $out/vmlinux
  '';
}
