{
  flake.modules.homeManager.niri = {
    xdg.configFile."niri/config.kdl".text = ''
      input {
          keyboard {
              xkb {
                  layout "fr"
              }
          }
          touchpad {
              tap
              natural-scroll
          }
          mouse {
              accel-profile "flat"
              accel-speed -0.1
          }
      }
    '';
  };
}
