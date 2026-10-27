{
  flake.modules.homeManager.apps =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        firefox
        vesktop
        spotify
        peazip
        kdePackages.okular
      ];
    };
}
