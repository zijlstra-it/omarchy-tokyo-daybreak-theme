#!/usr/bin/env bash
# Tokyo Daybreak — install script.
# Copies the theme into ~/.config/omarchy/themes/tokyo-daybreak, installs the
# theme-set hook into ~/.config/omarchy/hooks/theme-set.d/ (Omarchy only runs
# hooks from there, never from inside a theme directory), and activates it.
set -euo pipefail

script_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
config_root="${XDG_CONFIG_HOME:-$HOME/.config}"
theme_name="tokyo-daybreak"
theme_dir="$config_root/omarchy/themes/$theme_name"

mkdir -p "$theme_dir"
# Copy the theme without VCS metadata.
cp -a "$script_dir/." "$theme_dir/"
rm -rf "$theme_dir/.git" 2>/dev/null || true

# Install the theme-set hook where Omarchy's hook runner will execute it.
mkdir -p "$config_root/omarchy/hooks/theme-set.d"
cp "$script_dir/omarchy-hooks/theme-set.d/tokyo-daybreak" \
   "$config_root/omarchy/hooks/theme-set.d/tokyo-daybreak"
chmod +x "$config_root/omarchy/hooks/theme-set.d/tokyo-daybreak"

omarchy theme set "$theme_name"

# Point LazyVim at the active theme's neovim.lua (tokyonight-night) and poke
# running instances so the colorscheme applies immediately instead of waiting
# for Lazy's file watcher.
nvim_config="$config_root/nvim"
theme_link="$nvim_config/lua/plugins/theme.lua"
mkdir -p "$nvim_config/lua/plugins"
ln -sfn "$HOME/.local/state/omarchy/current/theme/neovim.lua" "$theme_link"
touch "$theme_link" 2>/dev/null || true

if command -v nvim >/dev/null 2>&1; then
  for sock in $(find "${XDG_RUNTIME_DIR:-/tmp}" -type s -name "nvim.*.0" 2>/dev/null | head -n 20); do
    nvim --server "$sock" --remote-send '<Cmd>doautocmd User LazyReload<CR>' >/dev/null 2>&1 || true
  done
fi
