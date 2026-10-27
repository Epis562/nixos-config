{ config, ... }:

# The graphical session. Pulls in the system side of every desktop feature
# and hands their home-manager side to every home-manager user on the host.
{
  flake.modules.nixos.desktop =
    { pkgs, ... }:
    {
      imports = with config.flake.modules.nixos; [
        niri
        greetd
        audio
        noctalia
      ];

      home-manager.sharedModules = [ config.flake.modules.homeManager.desktop ];

      hardware.bluetooth.enable = true;
      hardware.graphics.enable32Bit = true;
      services.gvfs.enable = true;

      fonts.packages = with pkgs; [
        nerd-fonts.jetbrains-mono
        noto-fonts
        noto-fonts-cjk-sans
        noto-fonts-color-emoji
      ];

      environment.systemPackages = with pkgs; [
        brightnessctl
        wlr-randr
      ];

      xdg.portal = {
        enable = true;
        extraPortals = [
          pkgs.xdg-desktop-portal-gnome
          pkgs.xdg-desktop-portal-gtk
        ];
        config.common.default = [ "gnome" "gtk" ];
      };
    };

  flake.modules.homeManager.desktop =
    { pkgs, ... }:
    {
      imports = with config.flake.modules.homeManager; [
        niri
        noctalia
        fuzzel
        alacritty
        theme
        audio
      ];

      home.packages = with pkgs; [
        wl-clipboard
        libnotify
        wdisplays
        nautilus
        sushi
        ffmpegthumbnailer
      ];

      xdg.mimeApps = {
        enable = true;
        defaultApplications = {
          "inode/directory" = [ "org.gnome.Nautilus.desktop" ];
        };
      };
    };
}
