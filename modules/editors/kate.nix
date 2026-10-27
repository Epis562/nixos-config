{
  flake.modules.homeManager.kate =
    { pkgs, ... }:
    {
      home.packages = [ pkgs.kdePackages.kate ];
    };
}
