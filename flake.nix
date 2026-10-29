{
  description = "NixOS + Niri + Noctalia Shell Multi-Host (dendritic)";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };

    import-tree.url = "github:vic/import-tree";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    noctalia = {
      url = "github:noctalia-dev/noctalia/cachix";
    };

    claude-desktop = {
      url = "github:k3d3/claude-desktop-linux-flake";
      # pinned to upstream's locked rev: it still uses nodePackages.asar
      inputs.nixpkgs.url = "github:NixOS/nixpkgs/6ad174a6dc07c7742fc64005265addf87ad08615";
    };
  };

  # Every .nix file under ./modules is a flake-parts module (paths containing
  # a `/_` segment are ignored by import-tree).
  outputs = inputs: inputs.flake-parts.lib.mkFlake { inherit inputs; } (inputs.import-tree ./modules);
}
