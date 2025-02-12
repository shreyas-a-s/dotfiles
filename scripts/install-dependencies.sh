#!/usr/bin/env bash
# Installs dependencies of the main install script on most linux distros

# Return if dependencies are already installed
if command -v stow > /dev/null && command -v fc-cache > /dev/null; then
  echo "Stow & fontconfig are already installed."
  return 0;
fi

# Install for debian-based distros
if command -v apt-get > /dev/null; then
  sudo apt-get install -y stow fontconfig
  return 0;
fi

# Install for archlinux-based distros
if command -v pacman > /dev/null; then
  sudo pacman -S --noconfirm stow fontconfig
  return 0;
fi

# Install for NixOS
if grep -iq nixos /etc/os-release; then
  nix-env -iA nixos.stow
  nix-env -iA nixos.fontconfig
  return 0;
fi

# Install for RHEL-based distros
if command -v dnf > /dev/null; then
  sudo dnf install -y stow fontconfig
  return 0;
fi

