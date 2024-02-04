#!/usr/bin/env bash

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

# Install stow if not already present in system
if ! command -v stow > /dev/null; then
  ./scripts/install-stow.sh
fi

# Remove already existing files & folders
xargs -a "./components/files-and-folders-to-remove.txt" rm -rf

# Actual setup of dotfiles
cd .. || exit
stow --adopt -vt ~ $(basename $SCRIPT_DIR) --dotfiles --ignore='install.sh|scripts|components'
cd "$SCRIPT_DIR"

# Move shell history files if they are present
if [ -f ~/.bash_history ]; then
  if [ -f ~/.local/share/bash/bash_history ]; then
    cat ~/.bash_history >> ~/.local/share/bash/bash_history
    rm ~/.bash_history
  else
    mv ~/.bash_history ~/.local/share/bash/bash_history
  fi
fi
if [ -f ~/.zsh_history ]; then
  if [ -f ~/.local/share/zsh/zsh_history ]; then
    cat ~/.zsh_history >> ~/.local/share/zsh/zsh_history
    rm ~/.zsh_history
  else
    mv ~/.zsh_history ~/.local/share/zsh/zsh_history
  fi
fi

# Post-installation things
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
    xargs -a "./components/declutter.txt" rm -f
esac

# Disable creation of ~/.Xauthority file
if [ -f ~/.Xauthority ]; then
  if command -v bash > /dev/null && ! grep -q 'XDG_RUNTIME' /etc/bash.bashrc; then # Disable using bash
    printf "\n# Prevent creation of .Xauthority\
    \nexport XAUTHORITY=\$XDG_RUNTIME_DIR/Xauthority\
    \n" | sudo tee -a /etc/bash.bashrc
  fi
  if command -v zsh > /dev/null && ! grep -q 'XDG_RUNTIME' "$zshenv_path"; then # Disable using zsh
    zshenv_path=$(sudo find /etc -maxdepth 2 -type f -name "zshenv")
    printf "\n# Prevent creation of .Xauthority\
    \nexport XAUTHORITY=\$XDG_RUNTIME_DIR/Xauthority\
    \n" | sudo tee -a "$zshenv_path"
  fi
  mv ~/.Xauthority "$XDG_RUNTIME_DIR"/Xauthority
fi

# Set gnome monospace font to my custom Nerd Font Noto Sans
fc-cache -f
if fc-list | grep -q 'NotoSansM Nerd Font' && command -v dconf > /dev/null; then
  dconf write /org/gnome/desktop/interface/monospace-font-name "'NotoSansM Nerd Font 11'"
fi

