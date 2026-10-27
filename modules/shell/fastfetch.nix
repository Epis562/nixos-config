{
  flake.modules.homeManager.fastfetch =
    { lib, ... }:
    {
      programs.zsh.initContent = lib.mkAfter ''
        fastfetch
      '';

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
