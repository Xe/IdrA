{ pkgs ? import <nixpkgs> { }, sources ? import ./sources.nix
, stdenv ? pkgs.stdenv, fetchurl ? pkgs.fetchurl }:

stdenv.mkDerivation rec {
  name = "x86_64-linux-musl-native";
  src = fetchurl {
    url = "http://musl.cc/x86_64-linux-musl-native.tgz";
    sha256 = "0kh9c3nd2ccc4p8yxw7i3pz330gjqgkllzam2kfqk1q6z9ax5y7m";
  };
  phases = "buildPhase installPhase";
  buildPhase = ''
    tar xzf $src
    ls -la
    mv ${name}/* .
  '';
  installPhase = ''
    mkdir -p $out
    cp -vrf * $out
  '';
}
