### SET XDG USER DIRECTORES ###
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share
export XDG_STATE_HOME=$HOME/.local/state

### EXPORT ###
export TERM="xterm-256color"                                  # For getting proper colors
export WGETRC=$XDG_CONFIG_HOME/wgetrc                         # To set xdg base directory for wget
export HISTCONTROL=ignoredups:erasedups:ignorespace           # No duplicate entries and no lines that start with a space
export LESSHISTFILE=-                                         # Prevent creation of ~/.lesshst file
export PYTHONSTARTUP="$XDG_CONFIG_HOME/python/pythonrc"       # Change python history file location

### COLORISE LESS ###
export LESS_TERMCAP_mb=$'\e[1;32m'
export LESS_TERMCAP_md=$'\e[1;32m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;4;31m'

### HISTORY SETTINGS ###
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=$XDG_DATA_HOME/bash/bash_history

# Set colors for ls command
if [ -f "$XDG_CONFIG_HOME/lscolors/lscolors.sh" ]; then
  . "$XDG_CONFIG_HOME"/lscolors/lscolors.sh
fi

### SET Chrome executable for Flutter
if command -v brave-browser > /dev/null; then
  export CHROME_EXECUTABLE="brave-browser"
fi

### SET MANPAGER ###
if command -v bat > /dev/null; then
  export MANPAGER="sh -c 'col -bx | bat -l man -p'"
  export MANROFFOPT="-c"
elif command -v batcat > /dev/null; then
  export MANPAGER="sh -c 'col -bx | batcat -l man -p'"
  export MANROFFOPT="-c"
else
  export MANPAGER='less'
  export LESS='-R --use-color -Dd+r$Du+b$'
  export MANROFFOPT='-P -c'
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
if [ -d "$HOME/.bin" ]; then
  PATH="$HOME/.bin:$PATH"
fi

if [ -d "$HOME/.local/bin" ]; then
  PATH="$HOME/.local/bin:$PATH"
fi

if [ -d "$HOME/Applications" ]; then
  PATH="$HOME/Applications:$PATH"
fi

if [ -d "/var/lib/flatpak/exports/bin/" ]; then
  PATH="/var/lib/flatpak/exports/bin/:$PATH"
fi

if [ -d "/usr/games/" ]; then
  PATH="/usr/games/:$PATH"
fi

if [ -d "/snap/bin/" ]; then
  PATH="/snap/bin/:$PATH"
fi

if [ -d "/home/linuxbrew/.linuxbrew/sbin" ]; then
  PATH="/home/linuxbrew/.linuxbrew/sbin:$PATH"
fi

if [ -d "/home/linuxbrew/.linuxbrew/bin" ]; then
  PATH="/home/linuxbrew/.linuxbrew/bin:$PATH"
fi

if [ -d "$HOME/github/flutter" ]; then
  PATH="$HOME/github/flutter/bin:$PATH"
fi

if [ -d "$HOME/.local/share/android/sdk" ]; then
  ANDROID_HOME="$HOME/.local/share/android/sdk"
fi

if [ -d "$ANDROID_HOME/cmdline-tools/latest/bin" ]; then
  PATH="$ANDROID_HOME/cmdline-tools/latest/bin:$PATH"
fi

if [ -d "/opt/nvim-linux-x86_64/bin/" ]; then
  PATH="$PATH:/opt/nvim-linux-x86_64/bin/"
fi

### SET EDITOR ###
if command -v nvim > /dev/null; then
  export EDITOR="nvim"
  export VISUAL="nvim"
  export SUDO_EDITOR="nvim"
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
if command -v nvim > /dev/null; then
  alias vim='nvim'
fi

# To set XDG Base Directory for wget
[ -f "$XDG_CONFIG_HOME"/wgetrc ] || touch "$XDG_CONFIG_HOME"/wgetrc && alias wget='wget --hsts-file=$XDG_CACHE_HOME/wget-hsts'

# Tree command - Show all files including hidden ones
alias tree='tree -a'

# Better ls commands
if command -v lsd > /dev/null; then
  alias ls='lsd -A'
  alias ll &> /dev/null && unalias ll # Delete alias ll if it exists
  function ll {
    if [ "$1" = "-g" ]; then
      shift
      lsd -Al --blocks permission,user,group,size,date,name --date +%d\ %b\ %H:%M --size short --group-directories-first "$@"
    elif [ "$1" = "-y" ]; then
      shift
      lsd -Al --blocks permission,user,group,size,date,name --date +%d\ %b\ %Y\ %H:%M --size short --group-directories-first "$@"
    else
      lsd -Al --blocks permission,user,size,date,name --date +%d\ %b\ %H:%M --size short --group-directories-first "$@"
    fi
  }
  alias lt='lsd -A --tree --group-directories-first -I .git'
else
  alias ls='ls -A --color=auto --group-directories-first'
  alias ll='ls -Alh --color=auto --group-directories-first'
  alias lt='tree --dirsfirst -I .git'
fi

# Colorize grep output (good for log files)
alias grep='grep -i --color=auto'
alias egrep='grep -E'
alias fgrep='grep -f'
alias rgrep='grep -r'
alias rg='rg -i'

# Adding flags
alias df='df -h'                          # human-readable sizes
alias free='free -m'                      # show sizes in MB

# Add verbose output to cp, mv & mkdir
alias cp='cp -iv'
alias mv='mv -iv'
alias mkdir='mkdir -pv'

# Enable command-line trash
if command -v trash > /dev/null; then
  alias rm='trash'
fi

# Colorize cat command
if command -v bat > /dev/null; then
  alias cat='bat --style=plain'
elif command -v batcat > /dev/null; then
  alias cat='batcat --style=plain'
fi

# Reason for space at the end: To make aliases work even if preceded by sudo
alias sudo='sudo '

# Change apt command to nala
if command -v nala > /dev/null; then
  alias apt='nala'
fi

# Allows shellcheck to follow any file the script may source
alias shellcheck='shellcheck -x'

# Force start btop even if no UTF-8 locale was detected
alias btop='btop --utf-force'

# Colorise ip command
alias ip='ip -color=auto'

### RANDOM COLOR SCRIPT ###
# Get this script from my Github: github.com/shreyas-a-s/shell-color-scripts
if command -v colorscript > /dev/null; then
  colorscript random
fi

### AUTOJUMP
if [ -f "/usr/share/autojump/autojump.zsh" ]; then
  . /usr/share/autojump/autojump.bash
elif command -v zoxide > /dev/null; then
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

function gbranch {
  git checkout -b "$1"
  git push -u origin "$1"
}

function gdelete {
  git push -d origin "$1"
  git checkout -
  git branch -d "$1"
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
    command ping -c 1 "$@"
  fi
}

### COMMAND-LINE PASTEBINS ###

# Function to use ix.io
function ix {
  curl -F "f:1=@$1" https://ix.io
  printf "\n"
}

# Function to use paste.rs
function paste {
  curl --data-binary "@$1" https://paste.rs
  printf "\n"
}

# Function to use 0x0.st
function 0x0 {
  curl -F "file=@$1" https://0x0.st
  printf "\n"
}

# Colorise diff
function diff {
  if command -v bat > /dev/null; then
    command diff -r "$@" | bat --style=plain -l diff
  elif command -v batcat > /dev/null; then
    command diff -r "$@" | batcat --style=plain -l diff
  else
    command diff -r --color=auto "$@"
  fi
}

### COMMAND-NOT-FOUND ###

# pkgfile "command not found" handler for bash
if [ -f /usr/share/doc/pkgfile/command-not-found.bash ]; then
  . /usr/share/doc/pkgfile/command-not-found.bash
fi

### SETTING THE STARSHIP PROMPT ###
if command -v starship > /dev/null; then
  eval "$(starship init bash)"
else
  PS1='\[\033[0;34m\]\w\[\033[0m\] $ '
fi

