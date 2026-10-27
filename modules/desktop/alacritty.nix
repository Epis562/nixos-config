{
  flake.modules.homeManager.alacritty = {
    programs.alacritty = {
      enable = true;
      settings = {
        font = {
          size = 13.0;
          normal = { family = "JetBrainsMono Nerd Font"; style = "Regular"; };
          bold = { family = "JetBrainsMono Nerd Font"; style = "Bold"; };
          italic = { family = "JetBrainsMono Nerd Font"; style = "Italic"; };
          bold_italic = { family = "JetBrainsMono Nerd Font"; style = "Bold Italic"; };
        };
        window = {
          opacity = 0.95;
          padding = { x = 12; y = 12; };
          decorations = "None";
        };
        scrolling = {
          history = 10000;
          multiplier = 3;
        };
        cursor.style = {
          shape = "Beam";
          blinking = "On";
        };
      };
    };
  };
}
