#!/usr/bin/env bash

# ██████╗  ██████╗ ████████╗███████╗██╗██╗     ███████╗███████╗
# ██╔══██╗██╔═══██╗╚══██╔══╝██╔════╝██║██║     ██╔════╝██╔════╝
# ██║  ██║██║   ██║   ██║   █████╗  ██║██║     █████╗  ███████╗
# ██║  ██║██║   ██║   ██║   ██╔══╝  ██║██║     ██╔══╝  ╚════██║
# ██████╔╝╚██████╔╝   ██║   ██║     ██║███████╗███████╗███████║
# ╚═════╝  ╚═════╝    ╚═╝   ╚═╝     ╚═╝╚══════╝╚══════╝╚══════╝

# Define Variables
SCRIPT_DIR=$(dirname -- "$( readlink -f -- "$0"; )") && cd "$SCRIPT_DIR" || exit
BASH_OLD_HISTORY="$HOME/.bash_history"
BASH_NEW_HISTORY="$HOME/.local/share/bash/bash_history"
ZSH_OLD_HISTORY="$HOME/.zsh_history"
ZSH_NEW_HISTORY="$HOME/.local/share/zsh/zsh_history"

# Gentle reminder
printf "This script will delete already present config files. Continue? (yes/no): " && read -r deletion_choice
case $deletion_choice in
  n|no|No|NO|N)
    exit 1 ;;
esac

# Install stow
./scripts/install-stow.sh

# Remove already existing files & folders
xargs -a "./components/files-and-folders-to-remove.txt" -I {} sh -c 'eval "rm -rf {}"'

# Actual setup of dotfiles
cd .. || exit
stow --adopt -vt ~ "$(basename "$SCRIPT_DIR")" --dotfiles --ignore='install.sh|scripts|components'

# Restore files if they were moved
git --git-dir="$SCRIPT_DIR/.git/" --work-tree="$SCRIPT_DIR" restore .

# Ensure the old history file exists and is readable
if [[ -f "$BASH_OLD_HISTORY" && -r "$BASH_OLD_HISTORY" ]]; then
    # Ensure the new history directory exists
    mkdir -p "$(dirname "$BASH_NEW_HISTORY")"

    # If the new history file exists and is writable, append old history
    if [[ -f "$BASH_NEW_HISTORY" && -w "$BASH_NEW_HISTORY" ]]; then
        cat "$BASH_OLD_HISTORY" >> "$BASH_NEW_HISTORY"
    else
        # Otherwise, move the old history file
        mv "$BASH_OLD_HISTORY" "$BASH_NEW_HISTORY"
    fi

    # Remove the old history file if it still exists after appending
    [[ -f "$BASH_OLD_HISTORY" ]] && rm -f "$BASH_OLD_HISTORY"
else
    echo "Error: $BASH_OLD_HISTORY does not exist or is not readable."
    exit 1
fi

# Ensure the new history directory exists
mkdir -p "$(dirname "$ZSH_NEW_HISTORY")"

# Ensure the old history file exists and is readable
if [[ -f "$ZSH_OLD_HISTORY" && -r "$ZSH_OLD_HISTORY" ]]; then
    # If the new history file exists and is writable, append old history
    if [[ -f "$ZSH_NEW_HISTORY" && -w "$ZSH_NEW_HISTORY" ]]; then
        cat "$ZSH_OLD_HISTORY" >> "$ZSH_NEW_HISTORY"
    else
        # Otherwise, move the old history file
        mv "$ZSH_OLD_HISTORY" "$ZSH_NEW_HISTORY"
    fi

    # Remove the old history file if it still exists after appending
    [[ -f "$ZSH_OLD_HISTORY" ]] && rm -f "$ZSH_OLD_HISTORY"
else
    echo "Error: $ZSH_OLD_HISTORY does not exist or is not readable."
    exit 1
fi

# Post-installation things
case "$(sh -c 'ps -p $$ -o ppid=' | xargs ps -o comm= -p)" in
  bash)
    source "$HOME/.bashrc" ;;
  fish)
    source "$HOME/.config/fish/config.fish" ;;
  zsh)
    source "$HOME/.config/zsh/.zshrc" ;;
esac

# Declutter HOME directory
printf "Do you want to declutter your home folder by removing some files? (yes/no): " && read -r declutter_choice
case $declutter_choice in
  y|yes|Yes|YES)
    xargs -a "$SCRIPT_DIR/components/declutter.txt" -I {} sh -c 'eval "rm -f {}"'
esac

# Disable creation of ~/.Xauthority file
if [ -f ~/.Xauthority ]; then
  if command -v bash > /dev/null && [ -f /etc/bash.bashrc ] && ! grep -q 'XDG_RUNTIME' /etc/bash.bashrc; then # Disable using bash
    printf "\n# Prevent creation of .Xauthority\
    \nexport XAUTHORITY=\$XDG_RUNTIME_DIR/Xauthority\
    \n" | sudo tee -a /etc/bash.bashrc
  fi

  # Store zshenv path into a variable
  zshenv_path=$(sudo find /etc -maxdepth 2 -type f -name "zshenv")
  if command -v zsh > /dev/null && ! grep -q 'XDG_RUNTIME' "$zshenv_path"; then # Disable using zsh
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

