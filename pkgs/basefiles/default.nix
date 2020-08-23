{ stdenv, sinit, startup }:

stdenv.mkDerivation {
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

    # passwd
    cp $src/etc/passwd $out/etc/passwd
  '';
}
