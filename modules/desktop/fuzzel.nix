{
  flake.modules.homeManager.fuzzel =
    { config, ... }:
    let
      p = config.palette;
    in
    {
      programs.fuzzel = {
        enable = true;
        settings = {
          main = {
            font = "JetBrainsMono Nerd Font:size=12";
            lines = 8;
            auto-select = true;
          };
          colors = {
            background = "${p.base}e6";
            text = "${p.text}ff";
            match = "${p.primary}ff";
            selection = "${p.surface}ff";
            selection-text = "${p.textBright}ff";
            selection-match = "${p.accent}ff";
            border = "${p.accent}ff";
          };
          border = {
            radius = 8;
            width = 1;
          };
        };
      };
    };
}
