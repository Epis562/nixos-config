{
  flake.modules.homeManager.fuzzel = {
    programs.fuzzel = {
      enable = true;
      settings = {
        main = {
          font = "JetBrainsMono Nerd Font:size=12";
          lines = 8;
          auto-select = true;
        };
        colors = {
          background = "1a1626e6";
          text = "e8e1f5ff";
          match = "cba6f7ff";
          selection = "41355eff";
          selection-text = "f5f0ffff";
          selection-match = "f5c2e7ff";
          border = "f5c2e7ff";
        };
        border = {
          radius = 8;
          width = 1;
        };
      };
    };
  };
}
