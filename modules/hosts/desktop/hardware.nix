# PLACEHOLDER until NixOS is installed on the desktop: replace the body with
# the output of `nixos-generate-config --show-hardware-config` (keep the
# `flake.modules.nixos.desktop-pc` wrapper). Until then it assumes the
# partition labels from the NixOS manual (`nixos` and `boot`).
{
  flake.modules.nixos.desktop-pc =
    { config, lib, modulesPath, ... }:
    {
      imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

      boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" ];
      boot.kernelModules = [ "kvm-amd" ];

      fileSystems."/" = {
        device = "/dev/disk/by-label/nixos";
        fsType = "ext4";
      };

      fileSystems."/boot" = {
        device = "/dev/disk/by-label/boot";
        fsType = "vfat";
        options = [ "fmask=0022" "dmask=0022" ];
      };

      nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
      hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    };
}
