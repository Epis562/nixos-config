{
  # Machines pull the config from GitHub instead of building it locally: CI
  # updates flake.lock weekly, builds every host, pushes the results to the
  # epis-nixos cache and merges. The upgrade is only staged here and becomes
  # active on the next boot.
  flake.modules.nixos.auto-upgrade = {
    nix.settings = {
      extra-substituters = [ "https://epis-nixos.cachix.org" ];
      extra-trusted-public-keys = [ "epis-nixos.cachix.org-1:zcfCaozdI0PhMes7xG+opvzugz6W6FJz645p3O5b7YE=" ];
    };

    system.autoUpgrade = {
      enable = true;
      flake = "github:Epis562/nixos-config";
      operation = "boot";
      dates = "daily";
      randomizedDelaySec = "45min";
      persistent = true;
    };
  };
}
