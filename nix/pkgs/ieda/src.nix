{
  stdenv,
  fetchgit,
  fetchpatch,
}:
stdenv.mkDerivation {
  pname = "iEDA-src";
  version = "0-unstable-2025-05-30";
  src = fetchgit {
    url = "https://gitee.com/oscc-project/iEDA";
    rev = "3096147fcea491c381da2928be6fb5a12c2d97b7";
    sha256 = "sha256-rPkcE+QFMlEuwwJ/QBgyLTXP5lWLQPj5SOlZysJ6WTI=";
    fetchSubmodules = true;
  };

  postPatch = ''
      # Comment out the iCTS test cases that will fail due to some linking issues on aarch64-linux
      sed -i '17,28s/^/# /' src/operation/iCTS/test/CMakeLists.txt
  '';

  patches = [
    # This patch is to fix the build error caused by the missing of the header file,
      # and remove some libs or path that they hard-coded in the source code.
      # Should be removed after we upstream these changes.
      (fetchpatch {
        url = "https://github.com/Emin017/iEDA/commit/e899b432776010048b558a939ad9ba17452cb44f.patch";
        hash = "sha256-fLKsb/dgbT1mFCWEldFwhyrA1HSkKGMAbAs/IxV9pwM=";
      })
      # This patch is to fix the compile error on the newer version of gcc/g++
      # which is caused by some incorrect declarations and usages of the Boost library.
      # Should be removed after we upstream these changes.
      (fetchpatch {
        url = "https://github.com/Emin017/iEDA/commit/3a2c7e27a5bd349d72b3a7198358cd640c678802.patch";
        hash = "sha256-2YROkQ92jGOJZr+4+LrwRJKxhA39Bypb1xFdo6aftu8=";
      })
  ];
  dontBuild = true;
  dontFixup = true;
  installPhase = ''
    cp -r . $out
  '';
}
