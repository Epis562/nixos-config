{
  flake.modules.nixos.spellcheck =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        hunspell
        hunspellDicts.fr-moderne
        aspell
        aspellDicts.fr
      ];

      environment.variables = {
        DICPATH = "${pkgs.hunspellDicts.fr-moderne}/share/hunspell";
      };
    };
}
