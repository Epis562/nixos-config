{ lib, config, inputs, ... }:

# Hosts are declared as `configurations.nixos.<hostname>.module` and turned
# into `nixosConfigurations.<hostname>` here.
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
}
