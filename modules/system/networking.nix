{
  flake.modules.nixos.networking = {
    networking = {
      networkmanager = {
        enable = true;
        dns = "none";
      };
      nameservers = [ "1.1.1.1" "9.9.9.9" ];
    };
  };
}
