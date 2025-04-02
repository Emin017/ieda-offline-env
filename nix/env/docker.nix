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
  self = pkgs.dockerTools.buildLayeredImage {
    name = "ieda-perf-docker";
    tag = "latest";
    contents = [
      git
      file
      which
      coreutils
      gnused
      nix
      wget
      curl

      bashInteractive
      dockerTools.binSh
      dockerTools.usrBinEnv

      ieda
    ];

    enableFakechroot = true;
    fakeRootCommands = ''
      mkdir -p /perfspace
    '';
    config = {
      Env = [
        "NIX_PAGER=cat"
        # A user is required by nix
        # https://github.com/NixOS/nix/blob/9348f9291e5d9e4ba3c4347ea1b235640f54fd79/src/libutil/util.cc#L478
        "USER=nobody"
        "EDITOR=nvim"
      ];
      WorkingDir = "/perfspace";
    };
  };
in
self
