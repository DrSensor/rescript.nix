final: prev: let
  inherit (final) lib stdenv fetchurl;

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
in {
  rescript = stdenv.mkDerivation rec {
    pname = "rescript";
    version = "11.0.0-rc.8";
    src = fetchurl {
      url = "https://registry.npmjs.org/rescript/-/rescript-${version}.tgz";
      hash = "sha256-HWP9H5YsLoIfuD9XdE9bkAjSrs+vNcPdSIG66/ShdN0=";
    };
    installPhase = ''
      install -D ${dist}/rescript.exe $out/bin/rescript
      for bin in bsc bsb_helper ninja
      do cp ${dist}/$bin.exe $out/bin/
      done
      cp -r lib/ $out/lib/
    '';
  };

  rescript-analysis = stdenv.mkDerivation rec {
    pname = "rescript-analysis";
    version = "1.32.0";
    src = fetchurl {
      url = "https://registry.npmjs.org/@rescript/language-server/-/language-server-${version}.tgz";
      hash = "sha256-uL+P+xkF/gFU6FSeDvb+pGVvI7ZN2NR4oL+kcEvYRSE=";
    };
    installPhase = ''
      install -D analysis_binaries/${dist}/rescript-editor-analysis.exe $out/bin/rescript-analysis
    '';
  };
}
