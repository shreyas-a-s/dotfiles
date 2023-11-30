### SET XDG USER DIRECTORES ###
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share
export XDG_STATE_HOME=$HOME/.local/state

### EXPORT ###
export TERM="xterm-256color"                                  # getting proper colors
export WGETRC=$XDG_CONFIG_HOME/wgetrc                         # to set xdg base directory for wget
export HISTCONTROL=ignoredups:erasedups:ignorespace           # no duplicate entries and no lines that start with a space
export LESSHISTFILE=-                                         # prevent creation of ~/.lesshst file
if which nvim > /dev/null; then
  export EDITOR="nvim"
  export VISUAL="nvim"
  export SUDO_EDITOR="nvim"
fi

### HISTORY SETTINGS ###
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=$XDG_CONFIG_HOME/bash/bash_history

# Set colors for ls command
if [ -f "$HOME/.config/lscolors/lscolors.sh" ]; then
  . $XDG_CONFIG_HOME/lscolors/lscolors.sh
fi

### SET MANPAGER ###
if which bat > /dev/null; then
  export MANPAGER="sh -c 'col -bx | bat -l man -p'"
elif which batcat > /dev/null; then
  export MANPAGER="sh -c 'col -bx | batcat -l man -p'"
fi

### BASH COMPLETION ###
if [ -f /usr/share/bash-completion/bash_completion ]; then
  . /usr/share/bash-completion/bash_completion
elif [ -f /etc/bash_completion ]; then
  . /etc/bash_completion
fi

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

### PATH ###
if [ -d "$HOME/.bin" ] ;
  then PATH="$HOME/.bin:$PATH"
fi

if [ -d "$HOME/.local/bin" ] ;
  then PATH="$HOME/.local/bin:$PATH"
fi

if [ -d "$HOME/Applications" ] ;
  then PATH="$HOME/Applications:$PATH"
fi

if [ -d "/var/lib/flatpak/exports/bin/" ] ;
  then PATH="/var/lib/flatpak/exports/bin/:$PATH"
fi

if [ -d "/usr/games/" ] ;
  then PATH="/usr/games/:$PATH"
fi

if [ -d "/snap/bin/" ] ;
  then PATH="/snap/bin/:$PATH"
fi

### SHOPT ###
shopt -s autocd # change to named directory
shopt -s cdspell # autocorrects cd misspellings
shopt -s cmdhist # save multi-line commands in history as single line
shopt -s dotglob # show hidden files in tab completion
shopt -s histappend # do not overwrite history
shopt -s expand_aliases # expand aliases
shopt -s checkwinsize # checks term size when bash regains control

# Ignore upper and lowercase when TAB completion
bind "set completion-ignore-case on"

# Show auto-completion list automatically, without double tab
bind "set show-all-if-ambiguous On"

### ALIASES ###

# To select correct neovim
if which nvim > /dev/null; then
  alias vim='nvim'
fi

# To set XDG Base Directory for wget
[ -f $XDG_CONFIG_HOME/wgetrc ] || touch $XDG_CONFIG_HOME/wgetrc && alias wget='wget --hsts-file=$XDG_CACHE_HOME/wget-hsts'

# Tree command - Show all files including hidden ones
alias tree='tree -a'

# Better ls commands
if which lsd > /dev/null; then
  alias ls='lsd -A'
  function ll {
    if [ "$1" = "-g" ]; then
      shift
      lsd -Al --blocks permission,user,group,size,date,name --date +%d\ %b\ %H:%M --size short --group-directories-first "$@"
    else
      lsd -Al --blocks permission,user,size,date,name --date +%d\ %b\ %H:%M --size short --group-directories-first "$@"
    fi
  }
  alias lt='lsd -A --tree --group-directories-first'
else
  alias ls='ls -A --color=auto --group-directories-first'
  alias ll='ls -Alh --color=auto --group-directories-first'
  alias lt='tree --dirsfirst'
fi

# Colorize grep output (good for log files)
alias grep='grep -i --color=auto'
alias egrep='grep -e'
alias fgrep='grep -f'
alias rgrep='grep -r'

# Adding flags
alias df='df -h'                          # human-readable sizes
alias free='free -m'                      # show sizes in MB

# Add verbose output to cp, mv & mkdir
alias cp='cp -iv'
alias mv='mv -iv'
alias mkdir='mkdir -pv'

# Enable command-line trash
if which trash > /dev/null; then
  alias rm='trash'
fi

# Colorize cat command
if which bat > /dev/null; then
  alias cat='bat --style=plain'
elif which batcat > /dev/null; then
  alias cat='batcat --style=plain'
fi

# Make aliases work even if preceded by sudo
alias sudo='nocorrect sudo -E '

# Change apt command to nala
if which nala > /dev/null; then
  alias apt='nala'
fi

# Allows shellcheck to follow any file the script may source
alias shellcheck='shellcheck -x'

# Force start btop even if no UTF-8 locale was detected
alias btop='btop --utf-force'

### RANDOM COLOR SCRIPT ###
# Get this script from my Github: github.com/shreyas-a-s/shell-color-scripts
if [ -f /usr/local/bin/colorscript ]; then
  colorscript random
fi

### AUTOJUMP
if [ -f "/usr/share/autojump/autojump.zsh" ]; then
  . /usr/share/autojump/autojump.bash
elif which zoxide > /dev/null; then
  eval "$(zoxide init bash)"
fi

### FUNCTIONS ###

# Git functions
function gcom {
  git add .
  git commit -m "$@"
}

function lazyg {
  git add .
  git commit -m "$@"
  git push
}

# Create and go to the directory
function mkdircd {
  mkdir -p "$1"
  cd "$1"
}

# My Ping ;)
function ping {
  if [ -z "$1" ]; then
    command ping -c 1 example.org
  else
    command ping "$@"
  fi
}

# Function to use ix.io (the command-line pastebin)
function ix {
  curl -F "f:1=@$1" ix.io
}

# Update all packages on system
function allup {
  if [ "$(command -v yay)" ]; then
    yay
  elif [ "$(command -v pacman)" ]; then
    sudo pacman -Syu
  fi

  if [ "$(command -v nala)" ]; then
    sudo nala upgrade
  elif [ "$(command -v apt)" ]; then
    sudo apt update && sudo apt upgrade
  fi

  [ "$(command -v snap)" ] && snap refresh
  [ "$(command -v flatpak)" ] && flatpak update

  return 0
}

### SETTING THE STARSHIP PROMPT ###
if which starship > /dev/null; then
  eval "$(starship init bash)"
fi

