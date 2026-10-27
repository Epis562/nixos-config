{ lib, config, inputs, ... }:

# Hosts are declared as `configurations.nixos.<hostname>.module` and turned
# into `nixosConfigurations.<hostname>` here. `nix flake check` builds them all.
{
  options.configurations.nixos = lib.mkOption {
    type = lib.types.lazyAttrsOf (
      lib.types.submodule {
        options.module = lib.mkOption {
          type = lib.types.deferredModule;
        };
      }
    );
    default = { };
  };

  config.flake.nixosConfigurations = lib.mapAttrs (
    name: { module }:
    inputs.nixpkgs.lib.nixosSystem {
      modules = [
        module
        { networking.hostName = lib.mkDefault name; }
      ];
    }
  ) config.configurations.nixos;

  config.perSystem =
    { system, ... }:
    {
      checks = lib.mapAttrs' (name: nixos: lib.nameValuePair "nixos-${name}" nixos.config.system.build.toplevel) (
        lib.filterAttrs (_: nixos: nixos.pkgs.stdenv.hostPlatform.system == system) config.flake.nixosConfigurations
      );
    };
}
