final: prev:
let
  iedaSrc = prev.callPackage ./pkgs/ieda/src.nix { };
in
{
  glog-lock = prev.glog.overrideAttrs (oldAttrs: rec {
    version = "0.6.0";
    src = final.fetchFromGitHub {
      owner = "google";
      repo = "glog";
      rev = "v${version}";
      sha256 = "sha256-xqRp9vaauBkKz2CXbh/Z4TWqhaUtqfbsSlbYZR/kW9s=";
    };
  });
  ieda = prev.callPackage ./pkgs/ieda { inherit iedaSrc; };

  rustpkgs = prev.callPackage ./pkgs/rustpkgs { inherit iedaSrc; };
  iir-rust = final.rustpkgs.iir-rust;
  liberty-parser = final.rustpkgs.liberty-parser;
  sdf-parse = final.rustpkgs.sdf_parse;
  spef-parser = final.rustpkgs.spef-parser;
  vcd-parser = final.rustpkgs.vcd_parser;
  verilog-parser = final.rustpkgs.verilog-parser;
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
