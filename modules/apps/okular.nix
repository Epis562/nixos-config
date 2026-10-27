{
  flake.modules.homeManager.okular =
    { pkgs, ... }:
    {
      home.packages = [ pkgs.kdePackages.okular ];
    };
}
