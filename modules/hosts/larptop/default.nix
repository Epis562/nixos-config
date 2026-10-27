{ config, ... }:

{
  configurations.nixos.larptop.module = config.flake.modules.nixos.larptop;

  flake.modules.nixos.larptop = {
    imports = with config.flake.modules.nixos; [
      base
      desktop
      gaming
      laptop
      docker
      flatpak
      spellcheck
      mrepis
    ];

    home-manager.sharedModules = [ config.flake.modules.homeManager.larptop ];

    system.stateVersion = "26.05";
  };
}
