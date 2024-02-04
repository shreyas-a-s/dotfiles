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
if ! command -v stow > dev/null; then
  ./scripts/install-stow.sh
fi

# Remove already existing files & folders
rm -rf ~/.local/bin/allup ~/.local/share/fonts/NotoSansMNerdFont-Regular.ttf ~/.bashrc ~/.icewm ~/.config/fish ~/.config/i3 ~/.config/i3status ~/.config/lscolors ~/.config/micro ~/.config/nvim ~/.config/picom ~/.config/python ~/.config/vifm ~/.config/zsh ~/.config/starship.toml ~/.config/user-dirs.dirs

# Actual setup of dotfiles
cd .. || exit
stow --adopt -vt ~ $(basename $SCRIPT_DIR) --dotfiles --ignore='install.sh|scripts'

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

