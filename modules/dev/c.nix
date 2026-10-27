{
  flake.modules.homeManager.c =
    { pkgs, ... }:
    {
      home.packages = [ pkgs.gcc ];
    };
}
