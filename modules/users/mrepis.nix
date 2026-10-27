{ config, ... }:

{
  flake.modules.nixos.mrepis =
    { pkgs, ... }:
    {
      imports = [ config.flake.modules.nixos.zsh ];

      users.users.mrepis = {
        isNormalUser = true;
        extraGroups = [ "wheel" "networkmanager" "video" "input" "docker" ];
        shell = pkgs.zsh;
      };

      home-manager.users.mrepis.imports = [ config.flake.modules.homeManager.mrepis ];
    };

  # Everything mrepis wants on every host. Desktop-session config (niri,
  # noctalia, ...) comes from the host's `desktop` module instead.
  flake.modules.homeManager.mrepis = {
    imports = with config.flake.modules.homeManager; [
      shell
      editors
      dev
      apps
    ];

    home.username = "mrepis";
    home.homeDirectory = "/home/mrepis";

    home.stateVersion = "26.05";
  };
}
