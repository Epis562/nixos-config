{
  flake.modules.nixos.amd-gpu =
    { pkgs, ... }:
    {
      hardware.graphics = {
        enable = true;
        enable32Bit = true;
      };

      hardware.amdgpu = {
        # Load the driver in the initrd for a flicker-free boot at native resolution.
        initrd.enable = true;
        # Unlocks clock/voltage/power-limit control (used by LACT).
        overdrive.enable = true;
        # ROCm OpenCL, needed by DaVinci Resolve and other GPU compute apps.
        opencl.enable = true;
      };

      # GPU monitoring, fan curves and overclocking.
      services.lact.enable = true;

      environment.systemPackages = with pkgs; [
        nvtopPackages.amd
        libva-utils
        vulkan-tools
      ];
    };
}
