{
  # Makes zsh available as a login shell; the actual config is home-manager's.
  flake.modules.nixos.shell = {
    programs.zsh.enable = true;
  };

  flake.modules.homeManager.shell =
    { config, pkgs, ... }:
    {
      home.packages = with pkgs; [
        bat
        lsd
        btop
      ];

      programs.direnv = {
        enable = true;
        nix-direnv.enable = true;
      };

      programs.zsh = {
        enable = true;
        enableCompletion = true;
        autosuggestion.enable = true;
        syntaxHighlighting.enable = true;

        initContent = ''
          export PS1="%{%F{165}%}%n%{%F{171}%}@%{%F{213}%}%m %{%F{219}%}%1~ %{%f%}$ "
          fastfetch
        '';

        oh-my-zsh = {
          enable = true;
          theme = "alanpeabody";
          plugins = [
            "git"
            "sudo"
            "command-not-found"
          ];
        };

        shellAliases = {
          ll = "lsd -lah";
          ls = "lsd -l";
          lst = "lsd -l --tree";
          cat = "bat";
          nrsw = "sudo nixos-rebuild switch --flake .#$(hostname)";
          up = "cd ${config.home.homeDirectory}/nixos-config/ && nix flake update && nrsw && reboot";
        };
      };

      programs.fastfetch = {
        enable = true;
        settings = {
          logo = {
            source = "NixOS2";
            padding.right = 2;
            color = {
              "1" = "38;2;180;142;173";
              "2" = "38;2;203;166;247";
            };
          };
          display.separator = " -> ";
          display.color = {
            keys = "38;2;203;166;247";
            separator = "38;2;180;142;173";
          };
          modules = [
            { type = "os"; key = "OS"; }
            { type = "kernel"; key = "Kernel"; }
            { type = "uptime"; key = "Uptime"; }
            { type = "shell"; key = "Shell"; }
            { type = "memory"; key = "Memory"; }
            { type = "swap"; key = "Swap"; }
            { type = "disk"; key = "Disk"; }
            { type = "battery"; key = "Battery"; }
          ];
        };
      };
    };
}
