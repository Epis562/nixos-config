{
  # Login shell for users; their config lives in the home-manager side.
  flake.modules.nixos.zsh = {
    programs.zsh.enable = true;
  };

  flake.modules.homeManager.zsh = {
    programs.zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;

      initContent = ''
        export PS1="%{%F{165}%}%n%{%F{171}%}@%{%F{213}%}%m %{%F{219}%}%1~ %{%f%}$ "
      '';

      oh-my-zsh = {
        enable = true;
        theme = "alanpeabody";
        plugins = [
          "git"
          "sudo"
          "command-not-found"
        ];
      };
    };
  };
}
