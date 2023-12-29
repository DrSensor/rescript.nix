final: prev: let
  inherit (final) lib stdenv fetchurl;
in {
  rescript = stdenv.mkDerivation rec {
    pname = "rescript";
    version = "11.0.0-rc.8";
    src = fetchurl {
      url = "https://registry.npmjs.org/rescript/-/rescript-${version}.tgz";
      hash = "sha256-HWP9H5YsLoIfuD9XdE9bkAjSrs+vNcPdSIG66/ShdN0=";
    };
    installPhase = let
      dist = let
        maybeArm64 = lib.optionalString stdenv.isAarch64 "arm64";
      in
        if stdenv.isLinux
        then "linux" + maybeArm64
        else if stdenv.isDarwin
        then "darwin" + maybeArm64
        else if stdenv.isCygwin || stdenv.isWindows
        then "win32"
        else throw "architecture not supported";
    in ''
      install -D ${dist}/rescript.exe $out/bin/rescript
      for bin in bsc bsb_helper ninja
      do cp ${dist}/$bin.exe $out/bin/
      done
      cp -r {,$out/}lib/
    '';
  };
}
