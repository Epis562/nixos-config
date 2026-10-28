# Settings for `nix run .#vm-<host>` (see flake/hosts.nix). They only apply
# to the VM build, never to the real system.
{
  flake.modules.nixos.vm = {
    virtualisation.vmVariant = {
      virtualisation = {
        memorySize = 6144;
        cores = 4;
        diskSize = 20480;
        # Accelerated virtio GPU, needed by Wayland compositors.
        qemu.options = [
          "-vga none"
          "-device virtio-vga-gl"
          "-display gtk,gl=on"
        ];
      };
    };
  };
}
