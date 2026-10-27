{
  flake.modules.nixos.file-manager = {
    services.gvfs.enable = true;
  };

  flake.modules.homeManager.file-manager =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
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
