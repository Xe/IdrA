{ sources ? import ../nix/sources.nix, pkgs ? import sources.nixpkgs { } }:

rec {
  gcc = pkgs.callPackage ./gcc { };

  sinit = pkgs.pkgsMusl.callPackage ./sinit {
    rcinit = "/etc/rc.init";
  };
}
