{
  flake.modules.homeManager.lsd =
    { pkgs, ... }:
    {
      home.packages = [ pkgs.lsd ];
      programs.zsh.shellAliases = {
        ll = "lsd -lah";
        ls = "lsd -l";
        lst = "lsd -l --tree";
      };
    };
}
