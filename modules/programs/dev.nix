{ config, inputs, ... }:

{
  flake.modules.homeManager.dev =
    { pkgs, ... }:
    {
      imports = [ config.flake.modules.homeManager.git ];

      home.packages = with pkgs; [
        python3Minimal
	uv
        jetbrains.jdk
        maven
        gcc
        elmPackages.nodejs
        antigravity-cli
        claude-code
	opencode
        inputs.claude-desktop.packages.${pkgs.stdenv.hostPlatform.system}.claude-desktop-with-fhs
      ];
    };
}
