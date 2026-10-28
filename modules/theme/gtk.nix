{
  flake.modules.homeManager.theme =
    { pkgs, ... }:
    {
      gtk = {
        enable = true;
        theme = {
          name = "Adwaita-dark";
          package = pkgs.gnome-themes-extra;
        };
        gtk3.extraConfig = {
          gtk-application-prefer-dark-themes = true;
        };
        gtk4.extraConfig = {
          gtk-application-prefer-dark-themes = true;
        };
      };

      dconf.settings = {
        "org/gnome/desktop/interface" = {
          color-scheme = "prefer-dark";
          gtk-theme = "Adwaita-dark";
        };
      };

      qt = {
        enable = true;
        platformTheme.name = "adwaita";
        style.name = "adwaita-dark";
      };
    };
}
