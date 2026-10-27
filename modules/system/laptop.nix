{
  flake.modules.nixos.laptop = {
    powerManagement.enable = true;
    services.tlp.enable = true;
    services.thermald.enable = true;
    services.upower.enable = true;
  };
}
