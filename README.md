# Tokyo Daybreak — Omarchy theme

## Fork & credits

Tokyo Daybreak is a **fork of the "Nous" Omarchy theme**
(https://github.com/notkisk/omarchy-nous-theme), adapted to give it a Tokyo
style: a light **Tokyo Day** desktop with dark **Tokyo Night** terminals and
editors. The original theme is MIT-licensed — see `LICENSE`.

The wallpapers in `backgrounds/` are third-party artwork; see `LICENSE` for 
the credits of the rightful owners.

## About

A light/dark hybrid in the Tokyo family: the **desktop GUI is light Tokyo Day**
(bar, panels, GTK, browsers, launchers) while **terminals and editors stay dark
Tokyo Night** (`#1a1b26`).

## How the split works

- `light.mode` (empty marker file) makes the desktop mode "light", so GUI apps
  and browsers render the light surfaces.
- `colors.toml` deliberately has **no `mode` key** and keeps the dark Tokyo
  Night palette for foot/kitty/alacritty/ghostty and other terminal apps.
- `foot.ini` pins `[colors-dark]` to the dark palette (foot's default theme
  section), so the terminal stays dark even with `prefer-light` set.
- `shell.toml` defines the light Tokyo Day bar and Hyprland borders.
- `neovim.lua` loads `tokyonight-night` via LazyVim.

## Hooks

Omarchy only executes hooks from `~/.config/omarchy/hooks/<event>.d/`, never
from inside a theme directory. The `omarchy-hooks/theme-set.d/tokyo-daybreak`
script in this theme is installed there by `install.sh`; it copies gtk.css,
fuzzel.ini, walker.css, the Waybar layout, mako.ini, swayosd.css and
starship.toml into the matching config locations, sets the light desktop
mode (`gsettings`: Adwaita + prefer-light), and restarts Waybar/Walker.
Like the stock tokyo-night theme, this theme ships no fastfetch files, so
fastfetch uses the system default (`/etc/fastfetch/config.jsonc`).

## Install

```bash
./install.sh
# or:
omarchy theme set tokyo-daybreak
```

## Backgrounds

Wallpapers live in `backgrounds/` and are picked automatically by Omarchy.
Cycle them later with:

```bash
omarchy theme bg next
```
