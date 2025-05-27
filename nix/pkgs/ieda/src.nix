{
  lib,
  stdenv,
  fetchgit,
  fetchpatch,
  LSAssigner4iEDA-src,
  spectra-src,
}:

let
  defaultVersion = "0-unstable-2025-04-14";
  defaultRemoteUrl = "https://gitee.com/oscc-project/iEDA";
  # Default values when no PR is specified, version: "2025-04-14"
  defaultRev = "51d198884cde2ecda643071a1a6cb4ec0e09d881";
  defaultHash = "sha256-kDVEAttSqa8l7qcRs7MQiBgPbAKBExEQvIE8tc7PLpM="; # Default sha256 for the default revision (2025-04-14)
  defaultPatches = [
    # This patch is to fix the build error caused by the missing of the header file,
    # and remove some libs or path that they hard-coded in the source code.
    # Should be removed after we upstream these changes.
    (fetchpatch {
      url = "https://github.com/Emin017/iEDA/commit/e899b432776010048b558a939ad9ba17452cb44f.patch";
      hash = "sha256-fLKsb/dgbT1mFCWEldFwhyrA1HSkKGMAbAs/IxV9pwM=";
    })
  ];
in

# Function that accepts PR number, remote URL, revision and patches
{
  pr ? null,
  iedaVersion ? defaultVersion,
  remoteUrl ? defaultRemoteUrl,
  rev ? null,
  hash ? defaultHash,
  patches ? null,
  ...
}:

let
  # Determine final values based on parameters
  finalRev =
    if rev != null then
      rev
    else if pr != null then
      "refs/pull/${toString pr}/head"
    else
      defaultRev;

  # Use provided patches or default patches
  finalPatches = if patches == null then defaultPatches else defaultPatches ++ patches;

  # Enable submodule fixup for older versions of iEDA. Versions older than the default
  enableSubmodulesFixup = lib.versionOlder defaultVersion iedaVersion;
in
stdenv.mkDerivation {
  pname = "iEDA-src";
  version = iedaVersion;
  src = fetchgit {
    url = remoteUrl;
    rev = finalRev;
    sha256 = hash;
    fetchSubmodules = false;
  };

  nativeBuildInputs = [
    LSAssigner4iEDA-src
    spectra-src
  ];

  patches = finalPatches;

  dontBuild = true;
  dontFixup = true;
  installPhase = ''
    cp -r . $out

    ${lib.optionals enableSubmodulesFixup ''
      # Copy third-party submodules to the output directory
      cp -r ${LSAssigner4iEDA-src}/* $out/src/third_party/LSAssigner4iEDA
      cp -r ${spectra-src}/* $out/src/third_party/spectra
    ''}
  '';
}
