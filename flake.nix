{
  nixConfig = {
    extra-trusted-substituters = [
      "https://serve.eminrepo.cc/"
    ];
    extra-trusted-public-keys = [ "serve.eminrepo.cc:fgdTGDMn75Z0NOvTmus/Z9Fyh6ExgoqddNVkaYVi5qk=" ];
  };

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
      flake.hydraJobs = {
        x86_64-linux = {
          iedaUnstable = inputs.self.packages.x86_64-linux.iedaUnstable;
        };
      };
      perSystem =
        {
          self',
          config,
          pkgs,
          system,
          ...
        }:
        {
          imports = [
            ./nix
          ];
          _module.args.pkgs = import inputs.nixpkgs {
            inherit system;
            overlays = [
              overlay
            ];
          };
          packages = {
            default = pkgs.iedaScope.iedaUnstable;
            inherit (pkgs.iedaScope)
              iedaUnstable
              ;
            inherit (pkgs)
              offlineDevBundle
              releaseDocker
              ;
          };
        };
    };
}
