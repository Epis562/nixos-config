{
  flake.modules.homeManager.firefox =
    { pkgs, ... }:
    {
      home.packages = [ pkgs.firefox ];
    };
}
