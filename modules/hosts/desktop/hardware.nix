{
  flake.modules.nixos.desktop-pc =
    {
      imports = [ ./_hardware-configuration.nix ];

      fileSystems."/media/games" = {
        device = "/dev/disk/by-uuid/2c8416b9-eeb8-4122-8758-0bde6c02eec8";
        fsType = "ext4";
	options = [ "nofail" ];
      };

      fileSystems."/media/data" = {
        device = "/dev/disk/by-uuid/6E0C8B510C8B12EF";
        fsType = "ntfs";
        options = [ "nofail" ];
      };

    };
}
