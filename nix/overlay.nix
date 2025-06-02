final: prev:
let
  # Prepare the submodules from the iEDA repository, see pkgs/ieda/submodules
  submoduleNames = builtins.attrNames (builtins.readDir ./pkgs/ieda/submodules);
  dropExt = with final.lib; map (name: (strings.removeSuffix ".nix" name) + "-src") submoduleNames;
  path = map (subDir: ./pkgs/ieda/submodules/${subDir}) submoduleNames;
  values = map (p: final.callPackage p { }) path;
  submodulesAttrs = with final.lib; builtins.listToAttrs (zipListsWith nameValuePair dropExt values);
in
{
  inherit (submodulesAttrs)
    LSAssigner4iEDA-src
    spectra-src
    ;

  glog-lock = prev.glog.overrideAttrs (oldAttrs: rec {
    version = "0.6.0";
    src = final.fetchFromGitHub {
      owner = "google";
      repo = "glog";
      rev = "v${version}";
      sha256 = "sha256-xqRp9vaauBkKz2CXbh/Z4TWqhaUtqfbsSlbYZR/kW9s=";
    };
  });

  iedaScope = final.callPackage ./pkgs/ieda { };

  rustpkgs-all = final.symlinkJoin {
    name = "rustpkgs-all";
    paths = with final; [
      iir-rust
      liberty-parser
      sdf-parse
      spef-parser
      vcd-parser
      verilog-parser
    ];
  };

  offlineDevBundle = final.callPackage ./env/offline/bundle.nix { };
  releaseDocker = final.callPackage ./env/docker.nix { };
}
