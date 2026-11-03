{ inputs, ... }:

{
  flake.modules.nixos.noctalia = {
    nix.settings = {
      extra-substituters = [ "https://noctalia.cachix.org" ];
      extra-trusted-public-keys = [ "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4=" ];
    };
  };

  flake.modules.homeManager.noctalia =
    { pkgs, ... }:
    {
      imports = [ inputs.noctalia.homeModules.default ];

      programs.noctalia = {
        enable = true;
        package = inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default;

        # Written to ~/.config/noctalia/config.toml. Changes made in the
        # settings GUI land in ~/.local/state/noctalia/settings.toml and
        # override these, so delete that file after copying them here.
        settings = {
          accessibility.ui_scale = 1.1;
          shell.font_family = "JetBrainsMono Nerd Font";

          bar.default = {
            background_opacity = 0.0;
            compositor_blur = false;
            concave_edge_corners = false;
            margin_edge = 6;
            radius = 20;
            scale = 1.4;
            shadow = false;
            thickness = 40;
            widget_spacing = 15;
            start = [
              "wallpaper"
              "workspaces"
            ];
            end = [
              "tray"
              "notifications"
              "clipboard"
              "network"
              "bluetooth"
              "volume"
              "battery"
              "control-center"
              "session"
            ];
          };

          widget = {
            clock = {
              capsule = true;
              capsule_fill = "tertiary";
              capsule_radius = 6;
              color = "on_secondary";
              format = "{:%d/%m/%y - %H:%M}";
            };
            network.show_label = false;
          };

          idle = {
            behavior_order = [
              "lock"
              "screen-off"
              "lock-and-suspend"
            ];
            pre_action_fade_seconds = 30;
            behavior = {
              lock = {
                action = "lock";
                enabled = true;
                timeout = 600.0;
              };
              screen-off = {
                action = "screen_off";
                enabled = true;
                timeout = 660.0;
              };
              lock-and-suspend = {
                action = "lock_and_suspend";
                enabled = true;
                timeout = 1800.0;
              };
            };
          };

          lockscreen.transition = [ "honeycomb" ];

          wallpaper = {
            directory = "/home/mrepis/walls";
            default.path = "/home/mrepis/walls/wallhaven-e8wdxl.png";
          };

          theme = {
            mode = "dark";
            source = "wallpaper";
            wallpaper_scheme = "m3-content";
            templates.builtin_ids = [
              "alacritty"
              "btop"
              "niri"
            ];
          };
        };
      };
    };
}
