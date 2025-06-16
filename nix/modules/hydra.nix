{ inputs, ... }:
{
  flake.hydraJobs = {
    x86_64-linux = {
      iedaUnstable = inputs.self.packages.x86_64-linux.ieda;
    };
  };
}
