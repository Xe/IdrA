{ sources ? import ../../sources.nix, pkgs ? import sources.nixpkgs { } }:

let
  src = pkgs.fetchurl {
    url = "https://ziglang.org/builds/zig-linux-x86_64-0.6.0+083c0f1ce.tar.xz";
    sha256 = "00piyhmj8qqv8f9ipxg3falvyrg61362dx03vv0yjz9yvzbl6np2";
  };
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
