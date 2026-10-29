{
  # Makes zsh available as a login shell; the actual config is home-manager's.
  flake.modules.nixos.shell = {
    programs.zsh.enable = true;
  };

  flake.modules.homeManager.shell =
    { config, lib, pkgs, ... }:
    let
      p = config.palette;
      prompt = map (c: "%{%F{${toString c}}%}") p.prompt;
      # "cba6f7" -> "38;2;203;166;247"
      rgb = hex: "38;2;" + lib.concatMapStringsSep ";" (i: toString (lib.fromHexString (builtins.substring i 2 hex))) [ 0 2 4 ];
    in
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
          export PS1="${builtins.elemAt prompt 0}%n${builtins.elemAt prompt 1}@${builtins.elemAt prompt 2}%m ${builtins.elemAt prompt 3}%1~ %{%f%}$ "
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
              "1" = rgb p.secondary;
              "2" = rgb p.primary;
            };
          };
          display.separator = " -> ";
          display.color = {
            keys = rgb p.primary;
            separator = rgb p.secondary;
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
