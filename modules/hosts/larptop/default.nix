{ config, ... }:

{
  configurations.nixos.larptop.module = config.flake.modules.nixos.larptop;

  flake.modules.nixos.larptop = {
    imports = with config.flake.modules.nixos; [
      base
      desktop
      niri
      gaming
      laptop
      docker
      flatpak
      spellcheck
      mrepis
    ];

    home-manager.sharedModules = with config.flake.modules.homeManager; [
      mauve
      larptop
    ];

    system.stateVersion = "26.05";
  };
}
