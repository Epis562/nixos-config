{
  flake.modules.nixos.flatpak =
    { pkgs, ... }:
    {
      services.flatpak.enable = true;

      systemd.services.flatpak-repo = {
        wantedBy = [ "multi-user.target" ];
        # Needs DNS; without this it runs too early and fails every boot.
        wants = [ "network-online.target" ];
        after = [ "network-online.target" ];
        serviceConfig = {
          Restart = "on-failure";
          RestartSec = "30s";
        };
        path = [ pkgs.flatpak ];
        script = ''
          flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
        '';
      };
    };
}
