{
  flake.modules.nixos.greetd =
    { config, lib, pkgs, ... }:
    {
      # Set by the compositor module (niri, hyprland, ...).
      options.greetd.session = lib.mkOption {
        type = lib.types.str;
        description = "Command tuigreet runs after logging in.";
      };

      config = {
        services.greetd = {
          enable = true;
          settings = {
            default_session = {
              command = "${pkgs.tuigreet}/bin/tuigreet --time --remember --remember-session --cmd ${lib.escapeShellArg config.greetd.session}";
              user = "greeter";
            };
          };
        };

        systemd.services.greetd.serviceConfig = {
          Type = "idle";
          StandardInput = "tty";
          StandardOutput = "tty";
          StandardError = "journal";
          TTYReset = true;
          TTYVHangup = true;
          TTYVTDisallocate = true;
        };
      };
    };
}
