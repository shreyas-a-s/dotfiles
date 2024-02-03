#!/usr/bin/env bash
# Installs stow program on most linux distros

# Install for debian-based distros
if command -v apt-get > /dev/null; then
  sudo apt-get install -y stow
fi

# Install for archlinux-based distros
if command -v pacman > /dev/null; then
  sudo pacman -S --noconfirm stow
fi

# Install for NixOS
if command -v nix-env > /dev/null; then
  nix-env -iA nixos.stow
fi

# Install for RHEL-based distros
if command -v dnf > /dev/null; then
  sudo dnf install -y stow
fi

