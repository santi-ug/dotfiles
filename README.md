# Dotfiles

This repository contains my full cross-platform dotfiles setup using **GNU Stow**  
for clean and reversible symlink management across **Arch Linux** and **macOS**.

## 📁 Folder Structure

```
dotfiles/
  arch/       → Arch-specific configs (Hyprland, Waybar, Fuzzel, Flameshot, etc.)
  macos/      → macOS-specific configs (empty for now until I get my Mac)
  common/     → Shared configs (Neovim, tmux, Starship, WezTerm, Git, Zsh, etc.)
```

### How it works

- **common/** holds everything shared across all systems  
  (Neovim, Zsh, tmux, starship, wezterm, etc.)

- **arch/** contains configs that only apply to Arch Linux  
  (Hyprland, Waybar, Fonts, etc.)

- **macos/** will contain configs only used on macOS  
  (Homebrew paths, macOS-specific settings, keybindings, etc.)

Each folder mirrors the structure of `$HOME`.  
Example:

```
common/.zshrc         → ~/.zshrc
common/.config/nvim   → ~/.config/nvim
arch/.config/hypr     → ~/.config/hypr
```

GNU Stow automatically creates symlinks from these directories into `$HOME`.

---

## 📦 Requirements

### Arch Linux

```bash
sudo pacman -S git stow
```

### macOS

```bash
brew install git stow
```

---

## 🚀 Installation

Clone the repo into **$HOME/dotfiles**:

```bash
git clone git@github.com/dreamsofautonomy/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

### 1. Install **shared** configuration (Linux or macOS)

```bash
stow common
```

This symlinks:

- `~/.zshrc`
- `~/.gitconfig`
- `~/.config/nvim`
- `~/.config/tmux`
- `~/.config/wezterm`
- `~/.config/starship.toml`

### 2. Install **Arch-specific** configuration

```bash
stow arch
```

This symlinks:

- Hyprland
- Waybar
- Flameshot
- Fuzzel
- any Arch-only settings

### 3. (Future) Install **macOS-specific** configuration

```bash
stow macos
```

This will be used once macOS-specific files exist.

---

## 🔄 Updating or Removing

Because Stow uses symlinks:

### Remove a module:

```bash
stow -D common
stow -D arch
stow -D macos
```

### Re-stow after updating dotfiles:

```bash
stow common
```

---

