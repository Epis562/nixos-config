{ lib, config, inputs, ... }:

# Hosts are declared as `configurations.nixos.<hostname>.module` and turned
# into `nixosConfigurations.<hostname>` here. `nix flake check` builds them all,
# and `nix run .#vm-<hostname>` boots one in a QEMU VM.
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
    let
      hosts = lib.filterAttrs (_: nixos: nixos.pkgs.stdenv.hostPlatform.system == system) config.flake.nixosConfigurations;
    in
    {
      checks = lib.mapAttrs' (name: nixos: lib.nameValuePair "nixos-${name}" nixos.config.system.build.toplevel) hosts;

      apps = lib.mapAttrs' (
        name: nixos:
        lib.nameValuePair "vm-${name}" {
          type = "app";
          program = "${nixos.config.system.build.vm}/bin/run-${name}-vm";
          meta.description = "Boot ${name} in a QEMU VM";
        }
      ) hosts;
    };
}
