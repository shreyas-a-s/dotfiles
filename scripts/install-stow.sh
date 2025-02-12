#!/usr/bin/env bash
# Installs stow program on most linux distros

# Return if stow is already installed
if command -v stow > /dev/null; then
  echo "Stow is already installed."
  return 0;
fi

# Install for debian-based distros
if command -v apt-get > /dev/null; then
  sudo apt-get install -y stow
fi

# Install for archlinux-based distros
if command -v pacman > /dev/null; then
  sudo pacman -S --noconfirm stow
fi

# Install for NixOS
if grep -iq nixos /etc/os-release; then
  nix-env -iA nixos.stow
fi

# Install for RHEL-based distros
if command -v dnf > /dev/null; then
  sudo dnf install -y stow
fi

