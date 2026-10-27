{ lib, config, ... }:

# `nix flake check` builds every host.
{
  perSystem =
    { system, ... }:
    {
      checks = lib.mapAttrs' (name: nixos: lib.nameValuePair "nixos-${name}" nixos.config.system.build.toplevel) (
        lib.filterAttrs (_: nixos: nixos.pkgs.stdenv.hostPlatform.system == system) config.flake.nixosConfigurations
      );
    };
}
