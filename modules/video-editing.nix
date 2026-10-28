{
  flake.modules.nixos.video-editing =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        kdePackages.kdenlive
        davinci-resolve
        audacity
        ffmpeg-full
        mediainfo
      ];
    };
}
