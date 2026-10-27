{
  flake.modules.nixos.desktop-utils =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        brightnessctl
        wlr-randr
      ];
    };

  flake.modules.homeManager.desktop-utils =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        wl-clipboard
        libnotify
        wdisplays
      ];
    };
}
