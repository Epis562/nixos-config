# Home-manager config specific to the desktop.
{
  flake.modules.homeManager.desktop-pc = {
    wayland.windowManager.hyprland.extraConfig = ''
      hl.monitor({ output = "HDMI-A-1", mode = "1920x1080@60",  position = "0x0",    scale = 1 })
      hl.monitor({ output = "DP-1",     mode = "1920x1080@144", position = "1920x0", scale = 1 })

      -- 1-5 on the 144Hz main monitor, 6-10 on the side one.
      for i = 1, 10 do
          hl.workspace_rule({
              workspace = tostring(i),
              monitor   = i <= 5 and "DP-1" or "HDMI-A-1",
              default   = i == 1 or i == 6,
          })
      end

      hl.on("hyprland.start", function()
          hl.exec_cmd("vesktop")
      end)

      hl.config({
          -- Variable refresh rate in fullscreen apps only.
          misc = { vrr = 2 },
          -- Lets games opt out of vsync for lower latency.
          general = { allow_tearing = true },
      })

      -- Geometry Dash's own fullscreen renders at a low resolution under
      -- Proton, so it runs windowed at 1920x1080 and Hyprland fullscreens it.
      hl.window_rule({
          name       = "geometry-dash-fullscreen",
          match      = { class = "^steam_app_322170$" },
          fullscreen = true,
      })

      hl.window_rule({
          name  = "games-tearing",
          match = { class = "^(steam_app_.*|gamescope)$" },
          immediate = true,
      })
    '';
  };
}
