{ config, ... }:

{
  configurations.nixos.desktop.module = config.flake.modules.nixos.desktop-pc;

  flake.modules.nixos.desktop-pc =
    { pkgs, ... }:
    {
      imports = with config.flake.modules.nixos; [
        base
        desktop
        hyprland
        amd-gpu
        gaming
        streaming
        video-editing
        docker
        flatpak
        spellcheck
        mrepis
      ];

      home-manager.sharedModules = with config.flake.modules.homeManager; [
        lagoon
        desktop-pc
      ];

      # Newest kernel for the latest amdgpu fixes.
      boot.kernelPackages = pkgs.linuxPackages_latest;

      system.stateVersion = "26.11";
    };
}
