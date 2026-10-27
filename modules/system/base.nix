{ config, ... }:

# Everything every host gets, regardless of what it is used for.
{
  flake.modules.nixos.base =
    { pkgs, ... }:
    {
      imports = with config.flake.modules.nixos; [
        locale
        networking
        home-manager
      ];

      nix.settings = {
        experimental-features = [ "nix-command" "flakes" ];
        auto-optimise-store = true;
      };
      nixpkgs.config.allowUnfree = true;

      nix.gc = {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 7d";
      };

      boot.loader.systemd-boot.enable = true;
      boot.loader.efi.canTouchEfiVariables = true;

      hardware.enableAllFirmware = true;

      environment.systemPackages = with pkgs; [
        vim
        git
        curl
        wget
        zip
        unzip
        tree
      ];
    };
}
