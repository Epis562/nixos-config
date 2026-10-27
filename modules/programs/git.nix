{
  flake.modules.homeManager.git =
    { pkgs, ... }:
    {
      home.packages = [ pkgs.gh ];

      programs.lazygit = {
        enable = true;
        settings = {
          gui = {
            theme = {
              activeBorderColor = [
                "magenta"
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
