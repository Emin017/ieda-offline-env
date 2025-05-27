{
  stdenv,
  fetchgit,
  fetchpatch,
  lib,
}:

# Function that accepts PR number, remote URL, revision and patches
{
  pr ? null,
  iedaVersion ? "2025-03-12",
  remoteUrl ? "https://gitee.com/oscc-project/iEDA",
  rev ? null,
  hash ? null,
  patches ? null,
  ...
}:

let
  # Default values when no PR is specified, version: "2025-03-12"
  defaultRev = "3a066726aa9521991a46d603f041831361d3ba51";
  defaultSha256 = "sha256-iPdp1xEje8bBumI/eqhvw0llg3NAzRb8pzc3fmWMwtU=";

  # Default patches
  defaultPatches = [
    # This patch is to fix the build error caused by the missing of the header file,
    # and remove some libs or path that they hard-coded in the source code.
    # Should be removed after we upstream these changes.
    (fetchpatch {
      url = "https://github.com/Emin017/iEDA/commit/e899b432776010048b558a939ad9ba17452cb44f.patch";
      hash = "sha256-fLKsb/dgbT1mFCWEldFwhyrA1HSkKGMAbAs/IxV9pwM=";
    })
  ];

  # Determine final values based on parameters
  finalRev =
    if rev != null then
      rev
    else if pr != null then
      "refs/pull/${toString pr}/head"
    else
      defaultRev;

  # When using a PR or custom rev, we can't predict sha256, so use lib.fakeHash
  finalSha256 = if hash == null then lib.fakeHash else hash;

  # Use provided patches or default patches
  finalPatches = if patches == null then defaultPatches else defaultPatches ++ patches;
in
stdenv.mkDerivation {
  pname = "iEDA-src";
  version = iedaVersion;
  src = fetchgit {
    url = remoteUrl;
    rev = finalRev;
    sha256 = finalSha256;
  };

  patches = finalPatches;

  dontBuild = true;
  dontFixup = true;
  installPhase = ''
    cp -r . $out
  '';
}
