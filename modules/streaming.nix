# Streaming and recording.
{ config, ... }:

{
  flake.modules.nixos.streaming =
    { pkgs, ... }:
    {
      programs.obs-studio = {
        enable = true;
        enableVirtualCamera = true;
        plugins = with pkgs.obs-studio-plugins; [
          wlrobs
          obs-pipewire-audio-capture
          obs-vkcapture
          obs-vaapi
          obs-backgroundremoval
        ];
      };

      # Low-overhead hardware-encoded recording and instant replays.
      programs.gpu-screen-recorder.enable = true;
      environment.systemPackages = [ pkgs.gpu-screen-recorder-gtk ];
    };
}
