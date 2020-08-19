{ pkgs ? import <nixpkgs> {} }:

let idra = import ./pkgs { };
in pkgs.mkShell {
  buildInputs = with pkgs; with idra; [
    zig

    # keep this line if you use bash
    bashInteractive
  ];
}
