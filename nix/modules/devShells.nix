{ pkgs, ... }:
{
  devShells = {
    default =
      with pkgs;
      mkShell {
        buildInputs = [
          nixd
        ];
      };
    ieda =
      with pkgs;
      mkShell {
        inputsFrom = [ self'.packages.default ];
        buildInputs = [
          cmake
        ];
      };

    rtl2gds =
      with pkgs;
      mkShell {
        buildInputs = [
          yosys
          ieda
          python312
          python312Packages.pyyaml
          python312Packages.orjson
          python312Packages.klayout
          python312Packages.pip
        ];
      };
  };
}
