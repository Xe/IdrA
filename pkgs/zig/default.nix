{ sources ? import ../../nix/sources.nix, pkgs ? import sources.nixpkgs { } }:

let
  src = sources.zig;
  version = "2020-08-19";

in pkgs.stdenv.mkDerivation {
  name = "zig";
  inherit src version;

  installPhase = ''
    mkdir -p $out
    cp -rf * $out
    mkdir -p $out/bin
    mv $out/zig $out/bin/zig
  '';
}
