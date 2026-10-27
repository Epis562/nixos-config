{ config, ... }:

# Everything every host gets, regardless of what it is used for.
{
  flake.modules.nixos.base = {
    imports = with config.flake.modules.nixos; [
      nix-settings
      nix-gc
      boot
      locale
      networking
      firmware
      base-packages
      home-manager
    ];
  };
}
