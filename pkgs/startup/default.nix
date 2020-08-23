{ stdenv, zig }:

stdenv.mkDerivation rec {
  pname = "startup";
  version = "0.1.0";
  src = ./src;
  buildInputs = [ zig ];
  phases = "buildPhase installPhase";
  buildPhase = ''
    export HOME=$TMPDIR;
    cp -rf $src/* .
    chmod a+w .
    zig build -Drelease-fast -Dtarget=native-linux-musl
  '';
  installPhase = ''
    mkdir -p $out/rc
    mv ./zig-cache/bin/startup $out/rc/startup
  '';
}
