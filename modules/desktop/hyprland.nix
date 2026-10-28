{ config, ... }:

{
  flake.modules.nixos.hyprland = {
    home-manager.sharedModules = [ config.flake.modules.homeManager.hyprland ];
    greetd.session = "uwsm start hyprland-uwsm.desktop";

    programs.hyprland = {
      enable = true;
      withUWSM = true;
      xwayland.enable = true;
    };

    # Virtio GPUs have no usable hardware cursor.
    virtualisation.vmVariant.home-manager.sharedModules = [
      {
        wayland.windowManager.hyprland.extraConfig = ''
          hl.config({ cursor = { no_hardware_cursors = true } })
        '';
      }
    ];
  };

  # Monitor rules are host-specific and get appended to this config from
  # hosts/<name>/home.nix.
  flake.modules.homeManager.hyprland =
    { config, pkgs, ... }:
    let
      p = config.palette;
    in
    {
      home.packages = [ pkgs.grimblast ];

      wayland.windowManager.hyprland = {
        enable = true;
        # Both come from the NixOS module.
        package = null;
        portalPackage = null;
        configType = "lua";
        # UWSM already manages the systemd session.
        systemd.enable = false;

        extraConfig = ''
          local mainMod = "SUPER"

          hl.on("hyprland.start", function()
              hl.exec_cmd("noctalia")
          end)

          hl.config({
              general = {
                  gaps_in     = 5,
                  gaps_out    = 15,
                  border_size = 3,
                  col = {
                      active_border   = { colors = { "rgba(${p.primary}ff)", "rgba(${p.secondary}ff)" }, angle = 45 },
                      inactive_border = "rgba(${p.surface}aa)",
                  },
                  layout = "dwindle",
              },

              decoration = {
                  rounding = 12,
              },

              dwindle = {
                  preserve_split = true,
              },

              misc = {
                  force_default_wallpaper = 0,
                  disable_hyprland_logo   = true,
              },

              input = {
                  kb_layout     = "fr",
                  follow_mouse  = 1,
                  accel_profile = "flat",
                  sensitivity   = -0.1,
              },
          })

          hl.window_rule({
              name  = "suppress-maximize-events",
              match = { class = ".*" },
              suppress_event = "maximize",
          })

          hl.window_rule({
              name  = "fix-xwayland-drags",
              match = { class = "^$", title = "^$", xwayland = true, float = true, fullscreen = false, pin = false },
              no_focus = true,
          })

          hl.bind(mainMod .. " + Q",         hl.dsp.window.close())
          hl.bind(mainMod .. " + SHIFT + E", hl.dsp.exit())
          hl.bind(mainMod .. " + F",         hl.dsp.window.fullscreen({ mode = "maximized" }))
          hl.bind(mainMod .. " + SHIFT + F", hl.dsp.window.fullscreen({ mode = "fullscreen" }))
          hl.bind(mainMod .. " + V",         hl.dsp.window.float({ action = "toggle" }))

          hl.bind(mainMod .. " + SPACE",  hl.dsp.exec_cmd("fuzzel"))
          hl.bind(mainMod .. " + B",      hl.dsp.exec_cmd("firefox"))
          hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd("alacritty"))
          hl.bind(mainMod .. " + E",      hl.dsp.exec_cmd("nautilus"))

          hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd("grimblast --notify copysave area"))

          for _, dir in ipairs({ "left", "right", "up", "down" }) do
              hl.bind(mainMod .. " + " .. dir,           hl.dsp.focus({ direction = dir }))
              hl.bind(mainMod .. " + SHIFT + " .. dir,   hl.dsp.window.move({ direction = dir }))
          end

          -- Number row by keycode, so it works with the AZERTY layout.
          for i = 1, 10 do
              local key = "code:" .. (i + 9)
              hl.bind(mainMod .. " + " .. key,         hl.dsp.focus({ workspace = i }))
              hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
          end

          hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
          hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))
          hl.bind(mainMod .. " + mouse:272",  hl.dsp.window.drag(),   { mouse = true })
          hl.bind(mainMod .. " + mouse:273",  hl.dsp.window.resize(), { mouse = true })

          hl.bind("XF86AudioRaiseVolume",  hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"),    { locked = true, repeating = true })
          hl.bind("XF86AudioLowerVolume",  hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),    { locked = true, repeating = true })
          hl.bind("XF86AudioMute",         hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),   { locked = true })
          hl.bind("XF86AudioMicMute",      hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), { locked = true })
          hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd("brightnessctl set +5%"),                        { locked = true, repeating = true })
          hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl set 5%-"),                        { locked = true, repeating = true })
          hl.bind("XF86AudioPlay",         hl.dsp.exec_cmd("playerctl play-pause"),                         { locked = true })
          hl.bind("XF86AudioNext",         hl.dsp.exec_cmd("playerctl next"),                               { locked = true })
          hl.bind("XF86AudioPrev",         hl.dsp.exec_cmd("playerctl previous"),                           { locked = true })
        '';
      };
    };
}
