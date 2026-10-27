{
  flake.modules.nixos.base-packages =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        vim
        git
        curl
        wget
        zip
        unzip
        tree
      ];
    };
}
