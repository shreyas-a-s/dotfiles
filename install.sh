#!/bin/sh

# Change directory
SCRIPT_DIR=$(dirname -- "$( readlink -f -- "$0"; )") && cd "$SCRIPT_DIR" || exit

# Gentle reminder
echo "This script will delete already present config files. Continue? (yes/no)" && read -r deletion_choice
case $deletion_choice in
  n|no|No|NO|N)
    exit 1 ;;
esac

# Create necessary directories
mkdir -p ~/.config
mkdir -p ~/.config/bash
mkdir -p ~/.config/fish
mkdir -p ~/.config/i3
mkdir -p ~/.config/i3status
mkdir -p ~/.config/lscolors
mkdir -p ~/.config/micro
mkdir -p ~/.config/nvim
mkdir -p ~/.config/picom
mkdir -p ~/.config/zsh
mkdir -p ~/.local/share/fonts/custom

# Symlink the files
rm ~/.bashrc && ln -s .bashrc ~/
ln -s .fonts/* ~/.local/share/fonts/custom/
rm ~/.config/starship.toml && ln -s .config/starship/toml ~/.config/
rm ~/.config/user-dirs.dirs && ln -s .config/user-dirs.dirs ~/.config/
rm ~/.config/fish/config.fish && ln -s .config/fish/config.fish ~/.config/fish/
rm ~/.config/i3/config && ln -s .config/i3/config ~/.config/i3/
rm ~/.config/i3status/config && ln -s .config/i3status/config ~/.config/i3status/
rm ~/.config/lscolors/lscolors.sh && ln -s .config/lscolors/lscolors.sh ~/.config/lscolors/
rm ~/.config/lscolors/lscolors.csh && ln -s .config/lscolors/lscolors.csh ~/.config/lscolors/
rm ~/.config/micro/settings/json && ln -s .config/micro/settings.json ~/.config/micro/
rm ~/.config/nvim/init.lua && ln -s .config/nvim/init.lua ~/.config/nvim/
rm ~/.config/picom/picom.conf && ln -s .config/picom/picom.conf ~/.config/picom/
rm ~/.config/zsh/.zshrc && ln -s .config/zsh/.zshrc ~/.config/zsh/
rm ~/.config/zsh/zsh-history-substring-search.zsh && ln -s .config/zsh/zsh-history-substring-search.zsh ~/.config/zsh/

# Post-installation things
fc-cache -vf
mv ~/.bash_history ~/.config/bash/bash_history
case "$(sh -c 'ps -p $$ -o ppid=' | xargs ps -o comm= -p)" in
  bash)
    source ~/.bashrc ;;
  fish)
    source ~/.config/fish/config.fish ;;
  zsh)
    source ~/.config/zsh/.zshrc ;;
esac

# Declutter HOME directory
echo "Do you want to declutter your home folder by removing some files? (yes/no)" && read -r declutter_choice
case $declutter_choice in
  y|yes|Yes|YES)
    rm ~/.bash_logout
    rm ~/.profile
    rm ~/.sudo_as_admin_successful
    rm ~/.wget-hsts
esac

