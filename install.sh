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
mkdir -p ~/.config
mkdir -p ~/.config/fish
mkdir -p ~/.config/i3
mkdir -p ~/.config/i3status
mkdir -p ~/.config/lscolors
mkdir -p ~/.config/micro
mkdir -p ~/.config/nvim
mkdir -p ~/.config/picom
mkdir -p ~/.config/zsh
mkdir -p ~/.config/vifm
mkdir -p ~/.config/python
mkdir -p ~/.local/share/fonts/custom
mkdir -p ~/.local/share/bash
mkdir -p ~/.local/share/zsh
mkdir -p ~/.local/share/python


# Symlink the files
rm -f ~/.bashrc; ln -s $(pwd)/.bashrc ~/
rm -f ~/.config/starship.toml; ln -s $(pwd)/.config/starship.toml ~/.config/
rm -f ~/.config/user-dirs.dirs; ln -s $(pwd)/.config/user-dirs.dirs ~/.config/
rm -f ~/.config/fish/config.fish; ln -s $(pwd)/.config/fish/config.fish ~/.config/fish/
rm -f ~/.config/i3/config; ln -s $(pwd)/.config/i3/config ~/.config/i3/
rm -f ~/.config/i3status/config; ln -s $(pwd)/.config/i3status/config ~/.config/i3status/
rm -f ~/.config/lscolors/lscolors.sh; ln -s $(pwd)/.config/lscolors/lscolors.sh ~/.config/lscolors/
rm -f ~/.config/lscolors/lscolors.csh; ln -s $(pwd)/.config/lscolors/lscolors.csh ~/.config/lscolors/
rm -f ~/.config/micro/settings.json; ln -s $(pwd)/.config/micro/settings.json ~/.config/micro/
rm -f ~/.config/nvim/init.lua; ln -s $(pwd)/.config/nvim/init.lua ~/.config/nvim/
rm -f ~/.config/picom/picom.conf; ln -s $(pwd)/.config/picom/picom.conf ~/.config/picom/
rm -f ~/.config/zsh/.zshrc; ln -s $(pwd)/.config/zsh/.zshrc ~/.config/zsh/
rm -f ~/.config/zsh/zsh-history-substring-search.zsh; ln -s $(pwd)/.config/zsh/zsh-history-substring-search.zsh ~/.config/zsh/
rm -f ~/.config/vifm/vifmrc; ln -s $(pwd)/.config/vifm/vifmrc ~/.config/vifm
rm -rf ~/.icewm/*; ln -s $(pwd)/.icewm/* ~/.icewm/
rm -f ~/.config/python/pythonrc; ln -s $(pwd)/.config/python/pythonrc ~/.config/python/
ln -s $(pwd)/.fonts/* ~/.local/share/fonts/custom/

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

