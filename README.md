# NixOS Dotfiles

Personal NixOS configuration using **Nix Flakes** and **Home Manager**.

It configures two machines: my laptop (`larptop`, niri, purple/mauve theme) and my desktop (`desktop`, Hyprland, green/blue theme, AMD GPU, set up for gaming, streaming, recording and video editing).

## System Overview

* **OS:** NixOS (using `nixos-unstable`)

* **Window Manager:** [Niri](https://github.com/YaLTeR/niri) on the laptop, [Hyprland](https://hypr.land) (Lua config, UWSM session) on the desktop

* **Shell & Bar:** [Noctalia](https://github.com/noctalia-dev/noctalia) shell

* **Display Manager / Greeter:** `greetd` with `tuigreet`

* **Locale & Keyboard Layout:** English and French locales, as well as French keyboard layout and French dictionaries 

* **Terminal:** Alacritty

* **Shell:** Zsh (with Oh My Zsh, autosuggestions, syntax highlighting, and Fastfetch)

* **App Launcher:** Fuzzel (themed from the host's palette)

* **Editor:** Neovim (basic config with Catppuccin Mocha theme, hybrid line numbers, Lualine)

* **Gaming:** Steam (with Proton-GE), GameMode, Gamescope, MangoHud, ProtonPlus

* **Desktop only:** AMD GPU (amdgpu in initrd, overdrive + LACT, ROCm OpenCL), OBS Studio (virtual camera, VAAPI, Vulkan game capture), GPU Screen Recorder, EasyEffects, Kdenlive, DaVinci Resolve, Audacity

## Repository Structure

The config follows the [dendritic pattern](https://github.com/mightyiam/dendritic): every `.nix` file under `modules/` is a [flake-parts](https://flake.parts) module, loaded automatically by [import-tree](https://github.com/vic/import-tree). File paths carry no meaning to Nix, they only exist for organisation, so files can be moved or renamed freely (a path segment starting with `_` is ignored).

Each file defines one *feature*, as `flake.modules.nixos.<name>` (system side) and/or `flake.modules.homeManager.<name>` (home-manager side). Features with real configuration get their own file; plain package lists and one-liners are folded into the bundle that uses them. Several files can still contribute to the same feature (e.g. `hosts/larptop/home.nix` appends monitor outputs to the niri config).

```
.
├── flake.nix                 # Inputs + `mkFlake (import-tree ./modules)`, nothing else
└── modules/
    ├── flake/                # Flake plumbing: systems, `configurations.nixos` -> nixosConfigurations, checks, VM apps
    ├── system/               # base (nix, boot, firmware, core packages), locale, networking, home-manager, laptop, spellcheck, vm
    ├── services/             # audio, docker, flatpak
    ├── desktop/              # desktop (bundle + fonts, portals, file manager...), niri, hyprland, greetd, noctalia, fuzzel, alacritty
    ├── theme/                # palette (mauve, lagoon), gtk/qt dark theme
    ├── hardware/             # amd-gpu
    ├── programs/             # shell (zsh, direnv, fastfetch...), neovim, editors, git, dev, apps
    ├── gaming.nix            # Steam, gamemode, gamescope, mangohud
    ├── streaming.nix         # OBS, gpu-screen-recorder, easyeffects
    ├── video-editing.nix     # Kdenlive, DaVinci Resolve, Audacity, ffmpeg
    ├── users/
    │   └── mrepis.nix        # The user account + their home-manager feature list
    └── hosts/
        ├── larptop/
        │   ├── default.nix   # Which features the laptop uses
        │   ├── hardware.nix  # Former hardware-configuration.nix
        │   └── home.nix      # Laptop-only home-manager bits (monitor outputs, kbd backlight aliases)
        └── desktop/
            ├── default.nix   # Which features the desktop uses (module name `desktop-pc`, hostname `desktop`)
            ├── hardware.nix  # PLACEHOLDER until NixOS is installed on it
            └── home.nix      # Monitors, VRR, tearing for games
```

### How features reach a machine

* A **host** (`hosts/<name>/default.nix`) declares `configurations.nixos.<name>` and imports NixOS features/bundles (`base`, `desktop`, `gaming`, `laptop`, ...) plus a user (`mrepis`).
* A **user** (`users/mrepis.nix`) creates the account and imports the home-manager features they want on every machine (`shell`, `editors`, `dev`, `apps`).
* The **desktop** bundle imports the system side of the graphical session *and* adds its home-manager side (noctalia, fuzzel, theme...) to every home-manager user of the host via `home-manager.sharedModules`. The compositor (`niri` or `hyprland`) is imported separately by the host and wires itself the same way, including the greetd session.
* The **palette** is picked per host by adding `mauve` or `lagoon` to `home-manager.sharedModules`. Fuzzel, fastfetch, the zsh prompt, lazygit and the compositor borders read their colours from it.
* Host-specific home-manager config (monitor layout, hardware quirks) lives in `hosts/<name>/home.nix` and is added the same way.

### Testing a host in a VM

```sh
nix run .#vm-desktop    # or .#vm-larptop
```

This boots the host in QEMU with an accelerated virtio GPU (6 GB RAM, 4 cores). Log in as `mrepis` with password `nixos`. The VM's disk is `./<host>.qcow2` (gitignored). Delete it to start from scratch. VM-only settings live in `virtualisation.vmVariant` (`system/vm.nix`, plus small bits in `users/mrepis.nix` and `desktop/hyprland.nix`) and never touch the real systems.

### Installing on the desktop

1. Boot the NixOS installer, partition the disk (labels `nixos` and `boot` match the placeholder), and run `nixos-generate-config --root /mnt`.
2. Replace the body of `modules/hosts/desktop/hardware.nix` with the generated `hardware-configuration.nix` (keep the `flake.modules.nixos.desktop-pc` wrapper).
3. `nixos-install --flake .#desktop`, then set a password with `passwd mrepis`.
4. Adjust the monitor rules in `modules/hosts/desktop/home.nix` (`hyprctl monitors` lists the outputs).

## Theme & Appearance

Each host uses one palette across components (`theme/palette.nix`): purple/mauve (`mauve`) on the laptop, green/blue (`lagoon`) on the desktop.

* **Fuzzel:** Background, matches, selection and border from the palette.

* **Fastfetch / zsh prompt / lazygit:** Logo, keys, prompt and borders from the palette.

* **Niri / Hyprland:** Focus ring / gradient window borders from the palette.

* **Neovim:** Catppuccin Mocha colorscheme with relative line numbering and custom statusline.

* **Terminal:** JetBrainsMono Nerd Font and 95% background opacity.

* **Noctalia:** Custom bar and appearance made in the GUI, so it's not present in this repo (yet)

## LLM Usage Notice

This config contains LLM-generated text. However, I have only ever used AI to speed up the writing of configurations. 99% of decisions have been made by me, and I have always double-checked every line written by an LLM. This README that you are reading right now has been initially written by an LLM but I heavily edited it.
