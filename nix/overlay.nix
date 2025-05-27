final: prev: {
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
  iedaSrcFetcher = final.callPackage ./pkgs/ieda/src.nix { };

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
