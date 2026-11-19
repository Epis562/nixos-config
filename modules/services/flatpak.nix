{ inputs, ... }:

{
  flake.modules.nixos.flatpak = {
    imports = [ inputs.nix-flatpak.nixosModules.nix-flatpak ];

    services.flatpak = {
      enable = true;

      # Flathub is the module's default remote; add others here with
      # `remotes = lib.mkOptionDefault [ { name = ...; location = ...; } ];`

      # Flatpaks installed on every host. Per-host extras can be added from
      # the host's default.nix with `services.flatpak.packages = [ ... ];`.
      # Find app IDs on https://flathub.org (the "org.foo.Bar" identifier).
      packages = [
        "org.vinegarhq.Sober"
        "org.vinegarhq.Vinegar"
      ];

      # Anything installed by hand (`flatpak install`) and not listed above is
      # removed on the next activation, so this file is the source of truth.
      uninstallUnmanaged = true;

      # Don't touch the network during `nixos-rebuild`; update weekly instead.
      update = {
        onActivation = false;
        auto = {
          enable = true;
          onCalendar = "weekly";
        };
      };
    };
  };
}
