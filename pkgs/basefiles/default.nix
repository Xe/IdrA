{ stdenv, sinit, startup }:

let sources = import ../../nix/sources.nix;
in stdenv.mkDerivation {
  pname = "basefiles";
  version = "mara";
  src = ./src;

  phases = "installPhase";

  installPhase = ''
    mkdir -p $out/bin
    mkdir $out/dev
    mkdir $out/etc
    mkdir $out/nix
    mkdir $out/rc

    # packages
    cp ${sinit}/bin/sinit $out/bin/sinit
    cp ${startup}/rc/startup $out/rc/startup

    # basefiles from musl.cc
    cp ${sources.mount} $out/bin/mount
    chmod +x $out/bin/mount
    cp ${sources.ip} $out/bin/ip
    chmod +x $out/bin/ip

    # passwd
    cp $src/etc/passwd $out/etc/passwd
  '';
}
