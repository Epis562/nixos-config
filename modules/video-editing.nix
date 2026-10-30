{
  flake.modules.nixos.video-editing =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        kdePackages.kdenlive
        audacity
        ffmpeg-full
        mediainfo
      ];
    };
}
