{ config, ... }:

{
  flake.modules.homeManager.editors =
    { pkgs, ... }:
    {
      imports = [ config.flake.modules.homeManager.neovim ];

      home.packages = with pkgs; [
        vscode
        jetbrains.idea
        jetbrains.webstorm
        kdePackages.kate
      ];
    };
}
