{ config, ... }:

{
  flake.modules.homeManager.dev = {
    imports = with config.flake.modules.homeManager; [
      git-tools
      python
      java
      c
      nodejs
      ai-tools
    ];
  };
}
