### DISABLE GREETING ###
set -U fish_greeting

### SET XDG USER DIRECTORES ###
set -gx XDG_CONFIG_HOME $HOME/.config
set -gx XDG_CACHE_HOME $HOME/.cache
set -gx XDG_DATA_HOME $HOME/.local/share
set -gx XDG_STATE_HOME $HOME/.local/state

### EXPORT ###
set TERM "xterm-256color"                                 # For getting proper colors
set -gx WGETRC $XDG_CONFIG_HOME/wgetrc                    # Set xdg base directory for wget
set LESSHISTFILE -                                        # Prevent creation of ~/.lesshst file
set -gx PYTHONSTARTUP "$XDG_CONFIG_HOME/python/pythonrc"  # Change python history file location

### COLORISE LESS ###
set -gx LESS_TERMCAP_mb (printf "\e[1;32m")
set -gx LESS_TERMCAP_md (printf "\e[1;32m")
set -gx LESS_TERMCAP_me (printf "\e[0m")
set -gx LESS_TERMCAP_se (printf "\e[0m")
set -gx LESS_TERMCAP_so (printf "\e[01;33m")
set -gx LESS_TERMCAP_ue (printf "\e[0m")
set -gx LESS_TERMCAP_us (printf "\e[1;4;31m")

# Set colors for ls command
if [ -f "$XDG_CONFIG_HOME/lscolors/lscolors.csh" ]
  . $XDG_CONFIG_HOME/lscolors/lscolors.csh
end

### CHANGE CURSOR SHAPE BASED ON MODE ###

# Change cursor shape for different vi modes.
fish_vi_cursor
set fish_cursor_default     line       blink
set fish_cursor_insert      block      blink
set fish_cursor_replace_one underscore blink
set fish_cursor_visual      block

# Set fish shell colors
set fish_color_command green
set -e fish_color_search_match

### SET Chrome executable for Flutter
if command -v brave-browser > /dev/null
  set -Ux CHROME_EXECUTABLE "brave-browser"
end

#### SET MANPAGER ###
if command -v bat > /dev/null
  set -xU MANPAGER "sh -c 'col -bx | bat -l man -p'"
  set -xU MANROFFOPT "-c"
else if command -v batcat > /dev/null
  set -xU MANPAGER "sh -c 'col -bx | batcat -l man -p'"
  set -xU MANROFFOPT "-c"
else
  set -xU MANPAGER 'less'
  set -xU LESS '-R --use-color -Dd+r$Du+b$'
  set -xU MANROFFOPT '-P -c'
end

### PATH ###
if [ -d "$HOME/.bin" ]
  set -Ux PATH "$HOME/.bin:$PATH"
end

if [ -d "$HOME/.local/bin" ]
  set -Ux PATH "$HOME/.local/bin:$PATH"
end

if [ -d "$HOME/Applications" ]
  set -Ux PATH "$HOME/Applications:$PATH"
end

if [ -d "/var/lib/flatpak/exports/bin/" ]
  set -Ux PATH "/var/lib/flatpak/exports/bin/:$PATH"
end  

if [ -d "/usr/games/" ]
  set -Ux PATH "/usr/games/:$PATH"
end

if [ -d "/snap/bin/" ]
  set -Ux PATH "/snap/bin/:$PATH"
end

if [ -d "/home/linuxbrew/.linuxbrew/sbin" ]
  set -Ux PATH "/home/linuxbrew/.linuxbrew/sbin:$PATH"

end

if [ -d "/home/linuxbrew/.linuxbrew/bin" ]
  set -Ux PATH "/home/linuxbrew/.linuxbrew/bin:$PATH"
end

if [ -d "$HOME/github/flutter" ]
  set -Ux PATH "$HOME/github/flutter"
end

if [ -d "$HOME/.local/share/android/sdk" ]
  set -Ux ANDROID_HOME "$HOME/.local/share/android/sdk"
fi

if [ -d "$ANDROID_HOME/cmdline-tools/latest/bin" ]
  set -Ux PATH "$ANDROID_HOME/cmdline-tools/latest/bin:$PATH"
fi

if [ -d "/opt/nvim-linux-x86_64/bin/" ]
  set -Ux PATH "$PATH:/opt/nvim-linux-x86_64/bin/"
fi

### SET EDITOR ###
if command -v nvim > /dev/null
  set EDITOR "nvim"
  set VISUAL "nvim"
  set SUDO_EDITOR "nvim"
end

### ALIASES ###

# To select correct neovim
if command -v nvim > /dev/null
  alias vim='nvim'
end

# To set XDG Base Directory for wget
[ -f $XDG_CONFIG_HOME/wgetrc ] || touch $XDG_CONFIG_HOME/wgetrc && alias wget='wget --hsts-file=$XDG_CACHE_HOME/wget-hsts'

# Tree command - Show all files including hidden ones
alias tree='tree -a'

# Better ls commands
if command -v lsd > /dev/null
  alias ls='lsd -A'
  alias | awk '{print $2}' | grep -qE '^ll$' && functions --erase ll # Delete alias ll if it exists
  function ll
    if [ -z "$argv" ] && [ "$argv[1]" = "-g" ]
      set -e argv[1]
      lsd -Al --blocks permission,user,group,size,date,name --date +%d\ %b\ %H:%M --size short --group-directories-first $argv
    else if [ -z "$argv" ] && [ "$argv[1]" = "-y" ]
      set -e argv[1]
      lsd -Al --blocks permission,user,group,size,date,name --date +%d\ %b\ %Y\ %H:%M --size short --group-directories-first $argv
    else
      lsd -Al --blocks permission,user,size,date,name --date +%d\ %b\ %H:%M --size short --group-directories-first $argv
    end
  end
  alias lt='lsd -A --tree --group-directories-first -I .git'
else
  alias ls='ls -A --color=auto --group-directories-first'
  alias ll='ls -Alh --color=auto --group-directories-first'
  alias lt='tree --dirsfirst -I .git'
end

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
if [ -f "/usr/bin/trash" ]
  alias rm='trash'
end

# Colorize cat command
if command -v bat > /dev/null
  alias cat='bat --style=plain'
else if command -v batcat > /dev/null
  alias cat='batcat --style=plain'
end

# Allows shellcheck to follow any file the script may source
alias shellcheck='shellcheck -x'

# Force start btop even if no UTF-8 locale was detected
alias btop='btop --utf-force'

# Making history show numbers like other shells
alias history='history -R | command cat -n'

# Colorise ip command
alias ip='ip -color=auto'

### RANDOM COLOR SCRIPT ###
# Get this script from my Github: github.com/shreyas-a-s/shell-color-scripts
if command -v colorscript > /dev/null
  colorscript random
end

### AUTOJUMP ###
if [ -f /usr/share/autojump/autojump.fish ]
  . /usr/share/autojump/autojump.fish
else if command -v zoxide > /dev/null
  zoxide init fish | source
end

### FUNCTIONS ###

# Git functions
function gcom
  git add .
  git commit -m "$argv"
end

function lazyg
  git add .
  git commit -m "$argv"
  git push
end

function gbranch
  git checkout -b "$argv[1]"
  git push -u origin "$argv[1]"
end

function gdelete
  git push -d origin "$argv[1]"
  git checkout -
  git branch -d "$argv[1]"
end

# Create and go to the directory
function mkdircd
  mkdir -pv "$argv"
  cd "$argv"
end

# Replacing 'sudo apt' with 'sudo nala' and 'sudo vim' with 'sudo nvim'
function sudo
  if [ "$argv[1]" = "apt" ] && [ (command -v nala > /dev/null; echo $status) -eq 0 ]
    set argv[1] nala && command sudo $argv
  else if [ "$argv[1]" = "vim" ] && [ (command -v nvim > /dev/null; echo $status) -eq 0 ]
    set argv[1] nvim && command sudo $argv
  else
    command sudo $argv
  end
end

# My Ping ;)
function ping
  if [ -z "$argv[1]" ]
    command ping -c 1 example.org
  else
    command ping -c 1 $argv
  end
end

### COMMAND-LINE PASTEBINS ###

# Function to use ix.io
function ix
  curl -F "f:1=@$argv[1]" https://ix.io
  printf "\n"
end

# Function to use paste.rs
function paste
  curl --data-binary "@$argv[1]" https://paste.rs
  printf "\n"
end

# Function to use 0x0.st
function 0x0
  curl -F "file=@$argv[1]" https://0x0.st
  printf "\n"
end

# Colorise diff
function diff
  if command -v bat > /dev/null
    command diff -r "$argv" | bat --style=plain -l diff
  else if command -v batcat > /dev/null
    command diff -r "$argv" | batcat --style=plain -l diff
  else
    command diff -r --color=auto "$argv"
  end
end

### OH MY FISH PLUGINS ###

# plugin-band-bang
function __history_previous_command
  switch (commandline -t)
  case "!"
    commandline -t $history[1]; commandline -f repaint
  case "*"
    commandline -i !
  end
end

function __history_previous_command_arguments
  switch (commandline -t)
  case "!"
    commandline -t ""
    commandline -f history-token-search-backward
  case "*"
    commandline -i '$'
  end
end

function _plugin-bang-bang_key_bindings --on-variable fish_key_bindings
    bind --erase !
    switch "$fish_key_bindings"
    case 'fish_default_key_bindings'
        bind --mode default ! __history_previous_command
    case 'fish_vi_key_bindings' 'fish_hybrid_key_bindings'
        bind --mode insert ! __history_previous_command
    end
end

_plugin-bang-bang_key_bindings

### SETTING THE STARSHIP PROMPT ###
if command -v starship > /dev/null
  starship init fish | source
end
