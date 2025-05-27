{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    parts.url = "github:hercules-ci/flake-parts";
    treefmt-nix.url = "github:numtide/treefmt-nix";
    treefmt-nix.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    inputs@{
      nixpkgs,
      parts,
      treefmt-nix,
      ...
    }:
    let
      overlay = import ./nix/overlay.nix;
    in
    parts.lib.mkFlake { inherit inputs; } {
      imports = [
        treefmt-nix.flakeModule
      ];
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];
      flake.overlays.default = overlay;
      perSystem =
        {
          self',
          config,
          pkgs,
          system,
          ...
        }:
        {
          _module.args.pkgs = import inputs.nixpkgs {
            inherit system;
            overlays = [
              overlay
            ];
          };
          treefmt = {
            projectRootFile = "flake.nix";
            programs = {
              nixfmt.enable = true;
              nixfmt.package = pkgs.nixfmt-rfc-style;
            };
            flakeCheck = true;
          };
          packages = {
            default = pkgs.iedaScope.ieda;
            ieda = pkgs.iedaScope.ieda;
            inherit (pkgs)
              offlineDevBundle
              releaseDocker
              ;
          };
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
        };
    };
}
