{
  flake.modules.homeManager.bat =
    { pkgs, ... }:
    {
      home.packages = [ pkgs.bat ];
      programs.zsh.shellAliases.cat = "bat";
    };
}
