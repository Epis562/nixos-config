{ config, ... }:

{
  flake.modules.homeManager.editors = {
    imports = with config.flake.modules.homeManager; [
      neovim
      vscode
      jetbrains
      kate
    ];
  };
}
