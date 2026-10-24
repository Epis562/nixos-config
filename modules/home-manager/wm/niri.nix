{ ... }:

{
  xdg.configFile."niri/config.kdl".text = ''
    spawn-at-startup "noctalia"

    output "eDP-1" {
        scale 1.0
    }

    output "HDMI-A-1" {
         scale 1.0
	 position x=1920 y=0
    }

    hotkey-overlay {
      skip-at-startup
    }



    prefer-no-csd

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

    layout {
        gaps 15 
        center-focused-column "never"

	focus-ring {
	    width 4
	    active-color "#b89cff"
	}
    }

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

    binds {
        Mod+Q { close-window; }
        Mod+Left  { focus-column-left; }
        Mod+Right { focus-column-right; }
	Mod+Up { focus-window-or-workspace-up; }
	Mod+Down { focus-window-or-workspace-down; }
        Mod+Shift+E { quit; }
	Mod+F { maximize-column; }
        Mod+Shift+F { fullscreen-window; }

        Mod+Space { spawn "fuzzel"; }
        Mod+B { spawn "firefox"; }
        Mod+Return { spawn "alacritty"; }
	Mod+E { spawn "nautilus"; }

	Mod+Shift+Left { move-column-left; }
	Mod+Shift+Right { move-column-right; }
	Mod+Shift+Up { move-window-to-workspace-up; }
	Mod+Shift+Down { move-window-to-workspace-down; }

	Mod+Shift+Ctrl+Right { move-column-to-monitor-right; }
	Mod+Shift+Ctrl+Left { move-column-to-monitor-left; }

	Mod+Shift+S { screenshot; }
	Mod+R { open-overview; }

	XF86AudioRaiseVolume  allow-when-locked=true { spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "5%+"; }
        XF86AudioLowerVolume  allow-when-locked=true { spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "5%-"; }
        XF86AudioMute         allow-when-locked=true { spawn "wpctl" "set-mute"   "@DEFAULT_AUDIO_SINK@" "toggle"; }
        XF86AudioMicMute      allow-when-locked=true { spawn "wpctl" "set-mute"   "@DEFAULT_AUDIO_SOURCE@" "toggle"; }

        XF86MonBrightnessUp   allow-when-locked=true { spawn "brightnessctl" "set" "+5%"; }
        XF86MonBrightnessDown allow-when-locked=true { spawn "brightnessctl" "set" "5%-"; }

        XF86AudioPlay         allow-when-locked=true { spawn "playerctl" "play-pause"; }
        XF86AudioNext         allow-when-locked=true { spawn "playerctl" "next"; }
        XF86AudioPrev         allow-when-locked=true { spawn "playerctl" "previous"; }
      }
  '';
}
