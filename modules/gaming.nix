{
  flake.modules.nixos.gaming =
    { pkgs, ... }:
    {
      programs.steam = {
        enable = true;
        remotePlay.openFirewall = true;
        dedicatedServer.openFirewall = true;
        extraCompatPackages = [ pkgs.proton-ge-bin ];
      };

      # `gamemoderun %command%` / `gamescope -- %command%` in Steam launch options.
      programs.gamemode.enable = true;
      programs.gamescope = {
        enable = true;
        capSysNice = true;
      };

      environment.systemPackages = with pkgs; [
        mangohud
        protonplus
      ];
    };
}
