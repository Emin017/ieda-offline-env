{
  stdenv,
  fetchFromGitHub,
}:

stdenv.mkDerivation {
  pname = "spectra-src";
  version = "0-unstable-2025-02-17";
  src = fetchFromGitHub {
    owner = "yixuan";
    repo = "spectra";
    rev = "a29f37fe3ed1c2895b07b449fcb8f09bc0940e40";
    sha256 = "sha256-75xZ4KTVqGhPyA5p5A0AmV4Z7mOMMZ194V2uZVesTaU=";
  };

  dontBuild = true;
  dontFixup = true;
  installPhase = ''
    cp -r . $out
  '';
}
