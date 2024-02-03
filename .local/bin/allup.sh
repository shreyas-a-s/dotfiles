#!/usr/bin/env bash
# Update all packages on system

# Function to draw a header with an input string
function pt { c=$(tput cols);t=$1;lt=${#t};lp=$(((c-lt)/2));function dl { echo;printf '%*s' "$c"|tr ' ' '-';};function al { echo;printf '%*s' "$lp";};dl;al;printf '%s' "$t";dl;}

[ "$(command -v pacman)" ] && pt "UPDATING - ARCHLINUX APPS"
if [ "$(command -v yay)" ]; then
  yay --noconfirm
elif [ "$(command -v pacman)" ]; then
  sudo pacman -Syu --noconfirm
fi

[ "$(command -v apt)" ] && pt "UPDATING - DEBIAN APPS"
if [ "$(command -v nala)" ]; then
  sudo nala upgrade -y
elif [ "$(command -v apt)" ]; then
  sudo apt update && sudo apt upgrade -y
fi

[ "$(command -v snap)" ] && pt "UPDATING - SNAP APPS" && sudo snap refresh
[ "$(command -v flatpak)" ] && pt "UPDATING - FLATPAK APPS" && flatpak update
[ "$(command -v auto-cpufreq)" ] && pt "UPDATING - AUTO-CPUFREQ" && sudo auto-cpufreq --update
[ "$(command -v nix-channel)" ] && pt "UPDATING - NIXOS" && sudo nixos-rebuild switch --upgrade --log-format bar-with-logs
[ "$(command -v dnf)" ] && pt "UPDATING - DNF PACKAGES" && sudo dnf upgrade -y
[ -f $HOME/.joplin/Joplin.AppImage ] && pt "UPDATING - JOPLIN" && wget -O - https://raw.githubusercontent.com/laurent22/joplin/dev/Joplin_install_and_update.sh | bash
