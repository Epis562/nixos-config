{
  flake.modules.homeManager.apps =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        firefox
        spotify
        peazip
        kdePackages.okular
        # VLC 3 only decodes AV1 (the OBS recordings) through its own dav1d
        # plugin, which nixpkgs doesn't build.
        (vlc.overrideAttrs (old: {
          buildInputs = old.buildInputs ++ [ dav1d ];
        }))
      ];
    };
}
