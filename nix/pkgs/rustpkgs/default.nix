{ iedaSrc, rustPlatform }:
let
  mkRustpkgs = _: p: rustPlatform.buildRustPackage p;
in
(builtins.mapAttrs mkRustpkgs {
  iir-rust = (
    attrs: {
      pname = "iir-rust";
      version = "0.1.3";
      src = iedaSrc;
      sourceRoot = "${attrs.src.name}/src/operation/iIR/source/iir-rust/iir";
      cargoBuildType = "release";

      useFetchCargoVendor = true;
      cargoHash = "sha256-CV1e/f3oCKW5mTbQnFBnp7E2d9nFyDwY3qclP2HwdPM=";

      doCheck = false;

      nativeBuildInputs = [ rustPlatform.bindgenHook ];
    }
  );
  liberty-parser = (
    attrs: {
      pname = "liberty-parser";
      version = "0.1.3";
      src = iedaSrc;
      sourceRoot = "${attrs.src.name}/src/database/manager/parser/liberty/lib-rust/liberty-parser";
      cargoBuildType = "release";

      useFetchCargoVendor = true;
      cargoHash = "sha256-nRIOuSz5ImENvKeMAnthmBo+2/Jy5xbM66xkcfVCTMI=";

      doCheck = false;
      nativeBuildInputs = [ rustPlatform.bindgenHook ];
    }
  );
  sdf_parse = (
    attrs: {
      pname = "sdf_parse";
      version = "0.1.0";
      src = iedaSrc;
      sourceRoot = "${attrs.src.name}/src/database/manager/parser/sdf/sdf_parse";
      cargoBuildType = "release";

      useFetchCargoVendor = true;
      cargoHash = "sha256-PORA/9DDIax4lOn/pzmi7Y8mCCBUphMTzbBsb64sDl0=";

      nativeBuildInputs = [ rustPlatform.bindgenHook ];
    }
  );
  spef-parser = (
    attrs: {
      pname = "spef-parser";
      version = "0.2.5";
      src = iedaSrc;
      sourceRoot = "${attrs.src.name}/src/database/manager/parser/spef/spef-parser";
      cargoBuildType = "release";

      useFetchCargoVendor = true;
      cargoHash = "sha256-Qr/oXTqn2gaxyAyLsRjaXNniNzIYVzPGefXTdkULmYk=";

      nativeBuildInputs = [ rustPlatform.bindgenHook ];
    }
  );
  vcd_parser = (
    attrs: {
      pname = "vcd_parser";
      version = "0.1.0";
      src = iedaSrc;
      sourceRoot = "${attrs.src.name}/src/database/manager/parser/vcd/vcd_parser";
      cargoBuildType = "release";

      useFetchCargoVendor = true;
      cargoHash = "sha256-xcfVzDrnW4w3fU7qo6xzSQeIH8sEbEyzPF92F5tDcAk=";

      doCheck = false;

      nativeBuildInputs = [ rustPlatform.bindgenHook ];
    }
  );
  verilog-parser = (
    attrs: {
      pname = "verilog-parser";
      version = "0.1.0";
      src = iedaSrc;
      sourceRoot = "${attrs.src.name}/src/database/manager/parser/verilog/verilog-rust/verilog-parser";
      cargoBuildType = "release";

      useFetchCargoVendor = true;
      cargoHash = "sha256-ooxY8Q8bfD+klBGfpTDD3YyWptEOGGHDoyamhjlSNTM=";

      doCheck = false;

      nativeBuildInputs = [ rustPlatform.bindgenHook ];
    }
  );
})