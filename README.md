# NixOS Dotfiles

Personal NixOS configuration using **Nix Flakes** and **Home Manager**.

Currently, it’s only configured for my laptop (named `larptop`), but moving my desktop to NixOS is planned. Thus, this config has been made with that goal in mind.

## System Overview

* **OS:** NixOS (using `nixos-unstable`)

* **Window Manager:** [Niri](https://github.com/YaLTeR/niri) 

* **Shell & Bar:** [Noctalia](https://github.com/noctalia-dev/noctalia) shell

* **Display Manager / Greeter:** `greetd` with `tuigreet`

* **Locale & Keyboard Layout:** English and French locales, as well as French keyboard layout and French dictionaries 

* **Terminal:** Alacritty

* **Shell:** Zsh (with Oh My Zsh, autosuggestions, syntax highlighting, and Fastfetch)

* **App Launcher:** Fuzzel (custom purple / mauve theme)

* **Editor:** Neovim (basic config with Catppuccin Mocha theme, hybrid line numbers, Lualine)

* **Gaming:** Steam enabled with required firewall ports

## Repository Structure

The config follows the [dendritic pattern](https://github.com/mightyiam/dendritic): every `.nix` file under `modules/` is a [flake-parts](https://flake.parts) module, loaded automatically by [import-tree](https://github.com/vic/import-tree). File paths carry no meaning to Nix, they only exist for organisation, so files can be moved or renamed freely (a path segment starting with `_` is ignored).

Each file defines one *feature*, as `flake.modules.nixos.<name>` (system side) and/or `flake.modules.homeManager.<name>` (home-manager side). Features with real configuration get their own file; plain package lists and one-liners are folded into the bundle that uses them. Several files can still contribute to the same feature (e.g. `hosts/larptop/home.nix` appends monitor outputs to the niri config).

```
.
├── flake.nix                 # Inputs + `mkFlake (import-tree ./modules)`, nothing else
└── modules/
    ├── flake/                # Flake plumbing: systems, `configurations.nixos` -> nixosConfigurations, checks
    ├── system/               # base (nix, boot, firmware, core packages), locale, networking, home-manager, laptop, spellcheck
    ├── services/             # audio, docker, flatpak
    ├── desktop/              # desktop (bundle + fonts, portals, file manager...), niri, greetd, noctalia, fuzzel, alacritty, theme
    ├── programs/             # shell (zsh, direnv, fastfetch...), neovim, editors, git, dev, apps
    ├── gaming.nix            # Steam
    ├── users/
    │   └── mrepis.nix        # The user account + their home-manager feature list
    └── hosts/
        └── larptop/
            ├── default.nix   # Which features the laptop uses
            ├── hardware.nix  # Former hardware-configuration.nix
            └── home.nix      # Laptop-only home-manager bits (monitor outputs, kbd backlight aliases)
```

### How features reach a machine

* A **host** (`hosts/<name>/default.nix`) declares `configurations.nixos.<name>` and imports NixOS features/bundles (`base`, `desktop`, `gaming`, `laptop`, ...) plus a user (`mrepis`).
* A **user** (`users/mrepis.nix`) creates the account and imports the home-manager features they want on every machine (`shell`, `editors`, `dev`, `apps`).
* The **desktop** bundle imports the system side of the graphical session *and* adds its home-manager side (niri config, noctalia, fuzzel, theme...) to every home-manager user of the host via `home-manager.sharedModules`.
* Host-specific home-manager config (monitor layout, hardware quirks) lives in `hosts/<name>/home.nix` and is added the same way.

### Adding the desktop

1. Generate its hardware config and put it in `modules/hosts/<name>/hardware.nix` as `flake.modules.nixos.<name>`, like the laptop.
2. Copy `modules/hosts/larptop/default.nix`, rename it, and drop `laptop` from the imports.
3. Put its monitor `output` blocks (and anything else machine-specific) in `modules/hosts/<name>/home.nix`.
4. `sudo nixos-rebuild switch --flake .#<name>`. `nix flake check` builds every host.

## Theme & Appearance

The desktop environment uses a coherent purple/mauve color palette across components:

* **Fuzzel:** Custom purple background with lavender search matching and borders.

* **Fastfetch:** Violet/lavender NixOS logo and mauve data keys.

* **Neovim:** Catppuccin Mocha colorscheme with relative line numbering and custom statusline.

* **Terminal:** JetBrainsMono Nerd Font and 95% background opacity.

* **Noctalia:** Custom bar and appearance made in the GUI, so it's not present in this repo (yet)

## LLM Usage Notice

This config contains LLM-generated text. However, I have only ever used AI to speed up the writing of configurations. 99% of decisions have been made by me, and I have always double-checked every line written by an LLM. This README that you are reading right now has been initially written by an LLM but I heavily edited it.
