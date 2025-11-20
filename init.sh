#!/bin/bash
set -e

# Startup of a new PC:

echo "[1/10] Creating folders..."
mkdir -p "$HOME/workspace"
mkdir -p "$HOME/perspace"
mkdir -p "$HOME/scripts"

echo "[2/10] Installing gcc..."
sudo apt update
sudo apt install -y gcc

echo "[3/10] Installing Homebrew dependencies..."
sudo apt install -y build-essential procps curl file git

echo "[4/10] Installing Homebrew..."
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Add brew to bashrc
echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> "$HOME/.bashrc"
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

echo "[5/10] Installing packages with Homebrew (fzf → fish → tmux)..."
brew install fzf
brew install fish
brew install tmux

echo "[6/10] Installing Ghostty..."
snap install ghostty --classic

## IF YOU USE UBUNTU/DEBIAN (recommended)
# sudo apt install -y flatpak
# flatpak install -y flathub com.mitchellh.ghostty

## IF YOU USE ARCH/ENDEAVOUR/ARTIX (uncomment this instead)
# sudo pacman -Sy --noconfirm ghostty

echo "[7/10] Configure Ghostty to use Fish..."
mkdir -p "$HOME/.config/ghostty"
echo "command = /home/linuxbrew/.linuxbrew/bin/fish" >> "$HOME/.config/ghostty/config"

echo "[8/10] Set Ghostty as default terminal (only works if installed via snap or .deb)..."
# This will only work if ghostty is actually installed at /snap/bin/ghostty
# If not, comment this.
sudo update-alternatives --install /usr/bin/x-terminal-emulator x-terminal-emulator /snap/bin/ghostty 50

echo "[9/10] Configure Fish to use Homebrew PATH..."
mkdir -p "$HOME/.config/fish"

# PATH for Homebrew
echo 'eval (/home/linuxbrew/.linuxbrew/bin/brew shellenv)' >> "$HOME/.config/fish/config.fish"

echo "[10/10] Clonando repositorio y copiando sesionizer..."

# Clone the repo temporally
git clone --depth 1 https://github.com/manuelsanchezto/dotfiles.git "$HOME/tmp_repo"

# Copy the script
cp "$HOME/tmp_repo/scripts/sesionizer" "$HOME/scripts/sesionizer"

# Give execution permissions
chmod +x "$HOME/scripts/sesionizer"

# Delete temporal repo
rm -rf "$HOME/tmp_repo"

echo "All done! 🎉"
