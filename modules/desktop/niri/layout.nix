{
  flake.modules.homeManager.niri = {
    xdg.configFile."niri/config.kdl".text = ''
      layout {
          gaps 15
          center-focused-column "never"

          focus-ring {
              width 4
              active-color "#b89cff"
          }
      }
    '';
  };
}
