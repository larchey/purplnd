# purplnd - Hyprland Nighttime Purple Theme

A complete Hyprland desktop configuration with a dark purple/nighttime aesthetic.

## Theme Preview

- **Colors**: Dark backgrounds (#0a0a12) with purple accents (#8a64b4, #c8a0e8)
- **Accent colors**: Cyan (#60a0c0), rose (#c06080), teal (#60a090)
- **Font**: JetBrainsMono Nerd Font

## Included Configurations

| Component | Description |
|-----------|-------------|
| `hypr/` | Hyprland WM config, keybindings, startup layout, copy/paste and on-screen volume/brightness scripts |
| `waybar/` | Status bar with purple gradient theme and a click-to-stay-awake (caffeine) toggle |
| `wofi/` | Application launcher styling |
| `kitty/` | Terminal with nighttime color scheme |
| `mako/` | Notification daemon, including the volume/brightness popup |
| `swaylock/` | Lock screen |
| `btop/` | System monitor with custom theme |
| `ncspot/` | Spotify TUI client theme |
| `neofetch/` | System info display, with owl |
| `herdr/` | herdr terminal workspace config |
| `sddm-theme/` | Login screen theme |

## Keybindings

### Core
| Key | Action |
|-----|--------|
| `Super + Return` | Open terminal (kitty) |
| `Super + Space` | App launcher (wofi) |
| `Super + Q` | Close window |
| `Super + F` | Fullscreen |
| `Super + C` | Copy (Ctrl+Shift+C in terminals) |
| `Super + V` | Paste (needs `wtype`) |
| `Super + Shift + C` | Clipboard history (clipman) |
| `Super + Shift + Space` | Toggle floating |
| `Super + Escape` | Lock screen |
| `Super + Shift + E` | Exit Hyprland |

### Window Management
| Key | Action |
|-----|--------|
| `Super + H/J/K/L` | Move focus (vim-style) |
| `Super + Shift + H/J/K/L` | Move window |
| `Super + Ctrl + H/J/K/L` | Resize window |
| `Super + 1-9` | Switch workspace |
| `Super + Shift + 1-9` | Move window to workspace |

### Media (Apple Keyboard fallback)
| Key | Action |
|-----|--------|
| `Super + F12` | Volume up |
| `Super + F11` | Volume down |
| `Super + F10` | Mute |
| `Super + F2` | Brightness up |
| `Super + F1` | Brightness down |

## Startup Layout

```
┌─────────────┬─────────────┐
│  terminal   │             │
│  (top-L)    │   firefox   │
├─────────────┤   (right)   │
│    btop     │             │
│  (bottom-L) │             │
└─────────────┴─────────────┘
```

Workspace 2 opens herdr (expects `~/.local/bin/herdr`).

## Installation

### 1. Install Dependencies (RHEL/Fedora)

```bash
# Enable EPEL (RHEL only)
sudo dnf install epel-release

# Core packages
sudo dnf install hyprland waybar wofi kitty mako swaylock swaybg swayidle \
                 grim slurp wl-clipboard clipman wtype jq libnotify \
                 brightnessctl playerctl btop neofetch network-manager-applet \
                 jetbrains-mono-fonts

# Fonts
mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts
curl -fLO https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/JetBrainsMono.zip
unzip JetBrainsMono.zip -d JetBrainsMono
rm JetBrainsMono.zip
fc-cache -fv

# Optional: ncspot (Spotify TUI) - requires Rust
cargo install ncspot
```

### 2. Install Configs

```bash
# Full install (packages, font, configs, login theme)
./install.sh

# Or only symlink the configs into ~/.config.
# Existing files are moved to ~/.config-backup-<timestamp> first.
./install.sh --link-only

# SDDM theme (requires sudo)
sudo cp -r sddm-theme /usr/share/sddm/themes/nighttime
sudo chmod -R 755 /usr/share/sddm/themes/nighttime
echo -e "[Theme]\nCurrent=nighttime" | sudo tee /etc/sddm.conf.d/theme.conf
```

The configs are symlinks into this folder, so edits show up in `git diff` right
away. Keep the folder where it is, or rerun `./install.sh --link-only` after
moving it. The login theme is a copy; reinstall it after editing.

## Notes

- **Scaling**: Set to 1.5x for HiDPI displays. Change in `hypr/hyprland.conf` line 4
- **Monitor**: Auto-detected. Modify `monitor =` line for multi-monitor setups
- **Apple Keyboard**: Volume/brightness use fallback Super+F-key bindings
- **Login font**: the SDDM owl needs a system-wide monospace font (`jetbrains-mono-fonts`); fonts in `~/.local` are not readable by SDDM
- **hypridle.conf** is not used; idle handling is `swayidle` in `hyprland.conf`
- **ncspot**: Requires Spotify Premium account
