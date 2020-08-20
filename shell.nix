{ pkgs ? import <nixpkgs> {} }:

let idra = import ./pkgs { };
in pkgs.mkShell {
  buildInputs = with pkgs; with idra; [
    zig
    removeReferencesTo

    # keep this line if you use bash
    bashInteractive
  ];
}
