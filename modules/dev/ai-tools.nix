{
  flake.modules.homeManager.ai-tools =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        antigravity-cli
        claude-code
      ];
    };
}
