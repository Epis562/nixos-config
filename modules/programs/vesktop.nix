{
  # Vesktop running nixpkgs' Vencord build with the GDAutoDeafen userplugin
  # baked in (https://github.com/snytex/AutoDeafen-Linux). The plugin listens on
  # 127.0.0.1:8787; the Geode mod in Geometry Dash connects there to (un)deafen.
  # Enable it once in Vencord → Plugins; the setting persists in ~/.config/vesktop.
  flake.modules.homeManager.apps =
    { pkgs, ... }:
    let
      vencord = pkgs.vencord.overrideAttrs (old: {
        # nixpkgs' Vencord can lag behind Discord changes (1.15.13 gave an empty
        # window). Bump `version` and both hashes when that happens again; drop
        # this pin once nixpkgs catches up.
        version = "1.15.16";
        src = pkgs.fetchFromGitHub {
          owner = "Vendicated";
          repo = "Vencord";
          tag = "v1.15.16";
          hash = "sha256-aUJubLJpyLAZWiOezqFxPY6oVPgWVPQpajFqrJvrO9U=";
        };
        # nixpkgs' @types/react lockfile fix is already upstream in this version.
        patches = [ ];
        postPatch = "";
        pnpmDeps = old.pnpmDeps.overrideAttrs {
          outputHash = "sha256-HS8uZNepvDefjrsG3buVLFCVv7sHvazcwdpcT3EQ/78=";
        };
        env = old.env // {
          VENCORD_HASH = "1.15.16";
        };

        # preBuild rather than postPatch: postPatch feeds into pnpmDeps' hash.
        preBuild = (old.preBuild or "") + ''
          mkdir -p src/userplugins/gdAutoDeafen
          cp ${./_gdAutoDeafen}/*.ts src/userplugins/gdAutoDeafen/
        '';
      });
    in
    {
      home.packages = [
        (pkgs.vesktop.override {
          withSystemVencord = true;
          inherit vencord;
        })
      ];
    };
}
