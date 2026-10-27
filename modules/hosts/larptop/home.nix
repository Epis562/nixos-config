# Home-manager config specific to this machine's hardware.
{
  flake.modules.homeManager.larptop = {
    xdg.configFile."niri/config.kdl".text = ''
      output "eDP-1" {
          scale 1.0
      }

      output "HDMI-A-1" {
          scale 1.0
          position x=1920 y=0
      }
    '';

    # ThinkPad keyboard backlight
    programs.zsh.shellAliases = {
      br0 = "brightnessctl -d \"tpacpi::kbd_backlight\" set 0";
      br2 = "brightnessctl -d \"tpacpi::kbd_backlight\" set 2";
    };
  };
}
