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
        # ROCm OpenCL, needed by DaVinci Resolve and other GPU compute apps.
        opencl.enable = true;
      };

      # Deliberately NOT enabled: hardware.amdgpu.overdrive and services.lact.
      # With them on, the RX 9060 XT's SMU stopped responding after resume from
      # suspend ("SMU: No response", "resume of IP block <smu> failed") and the
      # desktop never came back.

      environment.systemPackages = with pkgs; [
        nvtopPackages.amd
        libva-utils
        vulkan-tools
      ];
    };
}
