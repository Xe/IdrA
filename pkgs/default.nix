{ sources ? import ../nix/sources.nix, pkgs ? import sources.nixpkgs { } }:

rec {
  zig = pkgs.callPackage ./zig { };

  sinit = pkgs.callPackage ./sinit {
    rcinit = "/rc/startup";
    rcshutdown = "/rc/shutdown";
    rcreboot = "/rc/shutdown";
    inherit zig;
  };
  startup = pkgs.callPackage ./startup { inherit zig; };

  basefiles = pkgs.callPackage ./basefiles { inherit sinit startup; };

  kernel = pkgs.callPackage ./kernel { inherit basefiles; };
}
