{
  flake.modules.homeManager.nodejs =
    { pkgs, ... }:
    {
      home.packages = [ pkgs.elmPackages.nodejs ];
    };
}
