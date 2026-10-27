{
  flake.modules.homeManager.peazip =
    { pkgs, ... }:
    {
      home.packages = [ pkgs.peazip ];
    };
}
