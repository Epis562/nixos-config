# Niri's config.kdl is assembled from every module that appends to
# `xdg.configFile."niri/config.kdl".text` (see the other files in this
# directory, and hosts/*/ for monitor outputs).
{
  flake.modules.nixos.niri =
    { pkgs, ... }:
    {
      programs.niri.enable = true;
      programs.xwayland.enable = true;

      environment.systemPackages = [ pkgs.xwayland-satellite ];
    };

  flake.modules.homeManager.niri = {
    xdg.configFile."niri/config.kdl".text = ''
      spawn-at-startup "noctalia"

      hotkey-overlay {
          skip-at-startup
      }

      prefer-no-csd
    '';

    programs.zsh.loginExtra = ''
      if [ -z "$DISPLAY" ] && [ "$(tty)" = "/dev/tty1" ]; then
        exec niri
      fi
    '';
  };
}
