{
  pkgs,
  git,
  file,
  which,
  coreutils,
  bashInteractive,
  gnused,
  nix,
  wget,
  curl,
  dockerTools,
  ieda,
}:
let
  self = pkgs.dockerTools.buildImage {
    name = "ieda-docker";
    tag = "25-05-13";
    copyToRoot = pkgs.buildEnv {
      name = "image-root";
      paths = with pkgs; [
        git
        file
        which
        neovim
        coreutils
        gnused
        wget
        curl
        nix
        ieda

        bashInteractive
        dockerTools.binSh
        dockerTools.usrBinEnv
      ];
      pathsToLink = [ "/bin" ];
    };
    config = {
      Env = [
        "NIX_PAGER=cat"
        "USER=nobody"
        "EDITOR=nvim"
      ];
    };
  };
in
self
