# Colour palettes. Every home-manager user gets the `palette` option (see
# system/home-manager.nix) and each host picks one by adding
# `flake.modules.homeManager.<palette>` to `home-manager.sharedModules`.
#
# Colours are hex without `#`. `prompt` holds 256-colour codes for the zsh
# prompt, `ansi` is a named terminal colour for TUIs that only take those.
{
  flake.modules.homeManager.palette =
    { lib, ... }:
    {
      options.palette = lib.mkOption {
        type = lib.types.attrsOf lib.types.anything;
        description = "Colour palette shared by every themed program.";
      };
    };

  # Purple / mauve
  flake.modules.homeManager.mauve = {
    palette = {
      base = "1a1626";
      surface = "41355e";
      text = "e8e1f5";
      textBright = "f5f0ff";
      primary = "cba6f7";
      secondary = "b48ead";
      accent = "f5c2e7";
      focus = "b89cff";
      prompt = [ 165 171 213 219 ];
      ansi = "magenta";
    };
  };

  # Green / blue
  flake.modules.homeManager.lagoon = {
    palette = {
      base = "0e1a1f";
      surface = "1f4d4f";
      text = "dcf2ee";
      textBright = "f0fffc";
      primary = "7fdbb6";
      secondary = "5fa8d3";
      accent = "89dceb";
      focus = "4fd1c5";
      prompt = [ 36 43 38 81 ];
      ansi = "cyan";
    };
  };
}
