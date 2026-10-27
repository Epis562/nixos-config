{
  flake.modules.homeManager.neovim =
    { pkgs, ... }:
    {
      programs.neovim = {
        enable = true;
        defaultEditor = true;
        viAlias = true;
        vimAlias = true;

        plugins = with pkgs.vimPlugins; [
          catppuccin-nvim
          lualine-nvim
          nvim-web-devicons
        ];

        initLua = ''
          vim.opt.number = true
          vim.opt.relativenumber = true

          vim.opt.termguicolors = true
          vim.opt.signcolumn = "yes"
          vim.opt.cursorline = true

          require("catppuccin").setup({
            flavour = "mocha",
            transparent_background = true,
            styles = {
              comments = { "italic" },
              conditionals = { "italic" },
            },
          })
          vim.cmd.colorscheme("catppuccin")

          require("lualine").setup({
            options = {
              theme = "auto",
              icons_enabled = true,
              component_separators = '|',
              section_separators = "",
            },
          })
        '';
      };

      programs.zsh.shellAliases.nv = "nvim";
    };
}
