{ config, ... }:

{
  flake.modules.homeManager.apps = {
    imports = with config.flake.modules.homeManager; [
      firefox
      vesktop
      spotify
      peazip
      okular
    ];
  };
}
