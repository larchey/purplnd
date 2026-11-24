# Hyprland Nighttime Purple Theme - Dotfiles

A complete Hyprland desktop configuration with a dark purple/nighttime aesthetic.

## Theme Preview

- **Colors**: Dark backgrounds (#0a0a12) with purple accents (#8a64b4, #c8a0e8)
- **Accent colors**: Cyan (#60a0c0), rose (#c06080), teal (#60a090)
- **Font**: JetBrainsMono Nerd Font

## Included Configurations

| Component | Description |
|-----------|-------------|
| `hypr/` | Hyprland WM config, keybindings, startup script |
| `waybar/` | Status bar with purple gradient theme |
| `wofi/` | Application launcher styling |
| `kitty/` | Terminal with nighttime color scheme |
| `mako/` | Notification daemon |
| `swaylock/` | Lock screen |
| `btop/` | System monitor with custom theme |
| `ncspot/` | Spotify TUI client theme |
| `neofetch/` | System info display |
| `sddm-theme/` | Login screen theme |

## Keybindings

### Core
| Key | Action |
|-----|--------|
| `Super + Return` | Open terminal (kitty) |
| `Super + Space` | App launcher (wofi) |
| `Super + Q` | Close window |
| `Super + F` | Fullscreen |
| `Super + V` | Toggle floating |
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

## Installation

### 1. Install Dependencies (RHEL/Fedora)

```bash
# Enable EPEL (RHEL only)
sudo dnf install epel-release

# Core packages
sudo dnf install hyprland waybar wofi kitty mako swaylock swaybg \
                 grim slurp wl-clipboard brightnessctl playerctl \
                 btop neofetch NetworkManager-applet

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
# Run the install script
./install.sh

# Or manually:
cp -r hypr ~/.config/
cp -r waybar ~/.config/
cp -r wofi ~/.config/
cp -r kitty ~/.config/
cp -r mako ~/.config/
cp -r swaylock ~/.config/
cp -r btop ~/.config/
cp -r ncspot ~/.config/
cp -r neofetch ~/.config/

# SDDM theme (requires sudo)
sudo cp -r sddm-theme /usr/share/sddm/themes/nighttime
sudo chmod -R 755 /usr/share/sddm/themes/nighttime
echo -e "[Theme]\nCurrent=nighttime" | sudo tee /etc/sddm.conf.d/theme.conf
```

### 3. Make startup script executable

```bash
chmod +x ~/.config/hypr/startup.sh
```

## Notes

- **Scaling**: Set to 1.5x for HiDPI displays. Change in `hypr/hyprland.conf` line 4
- **Monitor**: Auto-detected. Modify `monitor =` line for multi-monitor setups
- **Apple Keyboard**: Volume/brightness use fallback Super+F-key bindings
- **ncspot**: Requires Spotify Premium account

## File Structure

```
hyprland-dotfiles/
├── README.md
├── install.sh
├── hypr/
│   ├── hyprland.conf      # Main config
│   ├── hypridle.conf      # Idle/lock timers
│   └── startup.sh         # Startup layout script
├── waybar/
│   ├── config             # Bar modules
│   └── style.css          # Purple theme
├── wofi/
│   ├── config
│   └── style.css
├── kitty/
│   └── kitty.conf         # Terminal theme
├── mako/
│   └── config             # Notifications
├── swaylock/
│   └── config             # Lock screen
├── btop/
│   ├── btop.conf
│   └── themes/
│       └── nighttime.theme
├── ncspot/
│   └── config.toml        # Spotify client
├── neofetch/
│   └── config.conf
└── sddm-theme/
    ├── Main.qml
    ├── metadata.desktop
    └── theme.conf
```
