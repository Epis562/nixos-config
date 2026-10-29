{
  flake.modules.homeManager.git =
    { config, pkgs, ... }:
    {
      home.packages = [ pkgs.gh ];

      programs.lazygit = {
        enable = true;
        settings = {
          gui = {
            theme = {
              activeBorderColor = [
                config.palette.ansi
                "bold"
              ];
              inactiveBorderColor = [
                "white"
              ];
              selectedLineBgColor = [
                "default"
              ];
            };
          };
        };
      };

      programs.zsh.shellAliases.lg = "lazygit";
    };
}
