{
  flake.modules.homeManager.java =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        jetbrains.jdk
        maven
      ];
    };
}
