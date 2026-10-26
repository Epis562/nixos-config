{ pkgs, inputs, ... }:

{
  imports = [
    inputs.noctalia.homeModules.default
    ./shell.nix
    ./terminal.nix
    ./neovim.nix
    ./wm/niri.nix
  ];

  home.username = "mrepis";
  home.homeDirectory = "/home/mrepis";

  programs.noctalia = {
    enable = true;
    package = inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default;
  };

  home.packages = with pkgs; [
    wl-clipboard
    wireplumber
    firefox
    fuzzel
    bat
    lsd
    vesktop
    spotify
    vscode
    jetbrains.idea
    jetbrains.webstorm
    python3Minimal
    jetbrains.jdk
    maven
    gcc
    antigravity-cli
    elmPackages.nodejs
    gh
    libnotify
    btop
    wdisplays
    nautilus
    sushi
    ffmpegthumbnailer
    playerctl
    opencode
    kdePackages.kate
    peazip
    kdePackages.okular
    lazygit
  ];

  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        font = "JetBrainsMono Nerd Font:size=12";
	lines = 8;
	auto-select = true;
      };
      colors = {
        background = "1a1626e6";
	text = "e8e1f5ff";
	match = "cba6f7ff";
	selection = "41355eff";
	selection-text = "f5f0ffff";
	selection-match = "f5c2e7ff";
	border = "f5c2e7ff";
      };
      border = {
        radius = 8;
	width = 1;
      };
    };
  };

  programs.lazygit = {
    enable = true;
    settings = {
      gui = {
        theme = {
          activeBorderColor = [
            "magenta"
            "bold"
          ];
          inactiveBorderColor = [
            "white"
          ];
          selectedLineBgColor = [
            "default"
          ];
        };
      };
    };
  };

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "inode/directory" = [ "org.gnome.Nautilus.desktop" ];
    };
  };

  gtk = {
    enable = true;
    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome-themes-extra;
    };
    gtk3.extraConfig = {
      gtk-application-prefer-dark-themes = true;
    };
    gtk4.extraConfig = {
      gtk-application-prefer-dark-themes = true;
    };
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      gtk-theme = "Adwaita-dark";
    };
  };

  qt = {
    enable = true;
    platformTheme.name = "adwaita";
    style.name = "adwaita-dark";
  };

  home.stateVersion = "26.05";
}
