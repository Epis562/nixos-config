{
  flake.modules.homeManager.rebuild-aliases =
    { config, ... }:
    {
      programs.zsh.shellAliases = {
        nrsw = "sudo nixos-rebuild switch --flake .#$(hostname)";
        up = "cd ${config.home.homeDirectory}/nixos-config/ && nix flake update && nrsw && reboot";
      };
    };
}
