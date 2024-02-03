#!/bin/sh

# ██████╗  ██████╗ ████████╗███████╗██╗██╗     ███████╗███████╗
# ██╔══██╗██╔═══██╗╚══██╔══╝██╔════╝██║██║     ██╔════╝██╔════╝
# ██║  ██║██║   ██║   ██║   █████╗  ██║██║     █████╗  ███████╗
# ██║  ██║██║   ██║   ██║   ██╔══╝  ██║██║     ██╔══╝  ╚════██║
# ██████╔╝╚██████╔╝   ██║   ██║     ██║███████╗███████╗███████║
# ╚═════╝  ╚═════╝    ╚═╝   ╚═╝     ╚═╝╚══════╝╚══════╝╚══════╝

# Change directory
SCRIPT_DIR=$(dirname -- "$( readlink -f -- "$0"; )") && cd "$SCRIPT_DIR" || exit

# Gentle reminder
printf "This script will delete already present config files. Continue? (yes/no): " && read -r deletion_choice
case $deletion_choice in
  n|no|No|NO|N)
    exit 1 ;;
esac

# Create necessary directories
mkdir -p ~/.icewm
mkdir -p ~/.local/share/fonts/custom
mkdir -p ~/.local/share/bash
mkdir -p ~/.local/share/zsh
mkdir -p ~/.local/share/python

# Symlink files and folders in .config
./scripts/symlink-config-dir.sh

# Symlink other files
rm -f ~/.bashrc; ln -s $(pwd)/.bashrc ~/
rm -rf ~/.icewm/*; ln -s $(pwd)/.icewm/* ~/.icewm/
ln -s $(pwd)/.local/share/fonts/* ~/.local/share/fonts/custom/

# Post-installation things
mv ~/.bash_history ~/.local/share/bash/bash_history
case "$(sh -c 'ps -p $$ -o ppid=' | xargs ps -o comm= -p)" in
  bash)
    source ~/.bashrc ;;
  fish)
    source ~/.config/fish/config.fish ;;
  zsh)
    source ~/.config/zsh/.zshrc ;;
esac

# Declutter HOME directory
printf "Do you want to declutter your home folder by removing some files? (yes/no): " && read -r declutter_choice
case $declutter_choice in
  y|yes|Yes|YES)
    rm -f ~/.bash_logout
    rm -f ~/.bash_profile
    rm -f ~/.profile
    rm -f ~/.sudo_as_admin_successful
    rm -f ~/.wget-hsts
esac

# Disable creation of ~/.Xauthority file
if [ -f ~/.Xauthority ]; then
  if command -v bash > /dev/null; then # Disable using bash
    printf "\n# Prevent creation of .Xauthority\
    \nexport XAUTHORITY=\$XDG_RUNTIME_DIR/Xauthority\
    \n" | sudo tee -a /etc/bash.bashrc
  fi
  if command -v zsh > /dev/null; then # Disable using zsh
    printf "\n# Prevent creation of .Xauthority\
    \nexport XAUTHORITY=\$XDG_RUNTIME_DIR/Xauthority\
    \n" | sudo tee -a /etc/zsh/zshenv
  fi
  mv ~/.Xauthority "$XDG_RUNTIME_DIR"/Xauthority
fi

# Set gnome monospace font to my custom Nerd Font Noto Sans
fc-cache -f
if fc-list | grep -q 'NotoSansM Nerd Font' && command -v dconf > /dev/null; then
  dconf write /org/gnome/desktop/interface/monospace-font-name "'NotoSansM Nerd Font 11'"
fi

