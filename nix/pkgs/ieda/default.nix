{
  lib,
  newScope,
  iedaSrcFetcher,
}:
lib.makeScope newScope (scope: {
  ieda = scope.callPackage ./ieda.nix { };
  iedaSrc = iedaSrcFetcher {
    pr = null;
    iedaVersion = "0.1.0";
    hash = null;
    remoteUrl = "https://gitee.com/oscc-project/iEDA";
  };
  rustpkgs = scope.callPackage ./rustpkgs { iedaSrc = scope.iedaSrc; };
  iir-rust = scope.rustpkgs.iir-rust;
  liberty-parser = scope.rustpkgs.liberty-parser;
  sdf-parse = scope.rustpkgs.sdf_parse;
  spef-parser = scope.rustpkgs.spef-parser;
  vcd-parser = scope.rustpkgs.vcd_parser;
  verilog-parser = scope.rustpkgs.verilog-parser;
})
