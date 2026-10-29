# Home-manager config specific to the desktop.
{
  flake.modules.homeManager.desktop-pc = {
    wayland.windowManager.hyprland.extraConfig = ''
      -- Every monitor at its highest refresh rate. Replace with one rule per
      -- output (see `hyprctl monitors`) to set positions.
      hl.monitor({ output = "", mode = "highrr", position = "auto", scale = 1 })

      hl.config({
          -- Variable refresh rate in fullscreen apps only.
          misc = { vrr = 2 },
          -- Lets games opt out of vsync for lower latency.
          general = { allow_tearing = true },
      })

      hl.window_rule({
          name  = "games-tearing",
          match = { class = "^(steam_app_.*|gamescope)$" },
          immediate = true,
      })
    '';
  };
}
