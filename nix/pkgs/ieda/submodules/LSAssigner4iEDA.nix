{
  stdenv,
  fetchgit,
}:

stdenv.mkDerivation {
  pname = "LSAssigner4iEDA-src";
  version = "0-unstable-2025-02-17";
  src = fetchgit {
    url = "https://gitee.com/li-jinyuan/LSAssigner4iEDA.git";
    rev = "acb8e662dc886c24e64ea49a3dde0562becdb770";
    sha256 = "sha256-rpxc1a2u/IUAn1+ZbuY0NNpm9OrZvWUJ/KeucewhKiI=";
  };

  dontBuild = true;
  dontFixup = true;
  installPhase = ''
    cp -r . $out
  '';
}
