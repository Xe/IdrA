{ sources ? import ../nix/sources.nix, pkgs ? import sources.nixpkgs { } }:

rec {
  kernel = pkgs.callPackage ./kernel { };

  zig = pkgs.callPackage ./zig { };

  sinit = pkgs.callPackage ./sinit {
    rcinit = "/rc/startup";
    rcshutdown = "/rc/shutdown";
    rcreboot = "/rc/shutdown";
    inherit zig;
  };
  startup = pkgs.callPackage ./startup { inherit zig; };
}
