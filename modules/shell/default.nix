{ config, ... }:

{
  flake.modules.homeManager.shell = {
    imports = with config.flake.modules.homeManager; [
      zsh
      direnv
      fastfetch
      bat
      lsd
      btop
      rebuild-aliases
    ];
  };
}
