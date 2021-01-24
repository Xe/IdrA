{ pkgs ? import <nixpkgs> { } }:

let idra = import ./pkgs { };
in pkgs.mkShell {
  buildInputs = with pkgs;
    with idra; [
      zig
      removeReferencesTo
      bison
      ncurses
      pkg-config
      flex
      openssl
      elfutils
      bc
      gawk
      hostname
      perl

      # keep this line if you use bash
      bashInteractive
    ];
}
