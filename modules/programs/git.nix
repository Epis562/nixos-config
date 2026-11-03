{
  flake.modules.homeManager.git =
    { config, ... }:
    {
      programs.git = {
        enable = true;
        settings = {
          user = {
            name = "epis";
            email = "jesaispas2006@gmail.com";
          };
          init.defaultBranch = "main";
          core.editor = "nvim -f";
        };
      };

      # Also registers `gh auth git-credential` as git's credential helper.
      # `gh auth setup-git` writes the helper's /nix/store path into
      # ~/.gitconfig, which breaks pushing once that gh is garbage-collected;
      # here the path is regenerated on every rebuild.
      programs.gh.enable = true;

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
