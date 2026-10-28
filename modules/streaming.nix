# Streaming and recording.
{ config, ... }:

{
  flake.modules.nixos.streaming =
    { pkgs, ... }:
    {
      home-manager.sharedModules = [ config.flake.modules.homeManager.streaming ];

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

  # Microphone noise suppression / EQ.
  flake.modules.homeManager.streaming = {
    services.easyeffects.enable = true;
  };
}
