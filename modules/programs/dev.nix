{ config, ... }:

{
  flake.modules.homeManager.dev =
    { pkgs, ... }:
    {
      imports = [ config.flake.modules.homeManager.git ];

      home.packages = with pkgs; [
        python3Minimal
        jetbrains.jdk
        maven
        gcc
        elmPackages.nodejs
        antigravity-cli
        claude-code
      ];
    };
}
