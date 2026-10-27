{
  flake.modules.homeManager.niri = {
    xdg.configFile."niri/config.kdl".text = ''
      window-rule {
          geometry-corner-radius 12
          clip-to-geometry true
      }

      window-rule {
          match app-id="firefox"
          default-column-width { proportion 0.8; }
      }

      window-rule {
          match app-id="Alacritty"
          draw-border-with-background false
      }

      window-rule {
          match app-id="vesktop"
          default-column-width { proportion 0.6; }
      }
    '';
  };
}
