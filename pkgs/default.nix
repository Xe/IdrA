{ sources ? import ../nix/sources.nix, pkgs ? import sources.nixpkgs { } }:

rec {
  gcc = pkgs.callPackage ./gcc { };
  zig = pkgs.callPackage ./zig { };

  sinit = pkgs.pkgsMusl.callPackage ./sinit {
    rcinit = "/rc/init";
    rcshutdown = "/rc/shutdown";
    rcreboot = "/rc/shutdown";
  };
  startup = pkgs.callPackage ./startup { inherit zig; };
}
