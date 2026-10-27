{ config, ... }:

# The graphical session. Pulls in the system side of every desktop feature
# and hands their home-manager side to every home-manager user on the host.
{
  flake.modules.nixos.desktop = {
    imports = with config.flake.modules.nixos; [
      niri
      greetd
      audio
      bluetooth
      graphics
      fonts
      portals
      file-manager
      noctalia
      desktop-utils
    ];

    home-manager.sharedModules = [ config.flake.modules.homeManager.desktop ];
  };

  flake.modules.homeManager.desktop = {
    imports = with config.flake.modules.homeManager; [
      niri
      noctalia
      fuzzel
      alacritty
      theme
      file-manager
      audio
      desktop-utils
    ];
  };
}
