{ sources ? import ../nix/sources.nix, pkgs ? import sources.nixpkgs { } }:

rec {
  zig = pkgs.callPackage ./zig { };

  kernel = pkgs.callPackage ./kernel { };
  sinit = pkgs.pkgsMusl.callPackage ./sinit {
    rcinit = "/rc/startup";
    rcshutdown = "/rc/shutdown";
    rcreboot = "/rc/shutdown";
    inherit zig;
  };
  startup = pkgs.callPackage ./startup { inherit zig; };
}
