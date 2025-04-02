{
  stdenv,
  fetchgit,
  fetchpatch,
}:
stdenv.mkDerivation {
  pname = "iEDA-src";
  version = "2025-03-12";
  src = fetchgit {
    url = "https://gitee.com/oscc-project/iEDA";
    rev = "3a066726aa9521991a46d603f041831361d3ba51";
    sha256 = "sha256-iPdp1xEje8bBumI/eqhvw0llg3NAzRb8pzc3fmWMwtU=";
  };

  patches = [
    # This patch is to fix the build error caused by the missing of the header file,
    # and remove some libs or path that they hard-coded in the source code.
    # Should be removed after we upstream these changes.
    (fetchpatch {
      url = "https://github.com/Emin017/iEDA/commit/0eb86754063df6e21b35fd1396363ebc75b760c5.patch";
      hash = "sha256-hdH6+g3eZUxDudWqTwbaWNKS0fwfUWJPp//dqGNJQfM=";
    })
  ];

  dontBuild = true;
  dontFixup = true;
  installPhase = ''
    cp -r . $out
  '';
}
