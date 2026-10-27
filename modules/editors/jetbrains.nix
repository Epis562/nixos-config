{
  flake.modules.homeManager.jetbrains =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        jetbrains.idea
        jetbrains.webstorm
      ];
    };
}
