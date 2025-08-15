echo -e "\033[32mHello, Master!\033[0m"
# Check for Homebrew on macOS and initialize if found
if [[ -f "/opt/homebrew/bin/brew" ]] then
  # If you're using macOS, you'll want this enabled
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Set the directory we want to store zinit and plugins
# Uses XDG data directory if available, otherwise ~/.local/share
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# Load starship prompt theme
# line 1: `starship` binary as command, from github release
# line 2: starship setup at clone(create init.zsh, completion)
# line 3: pull behavior same as clone, source init.zsh
zinit ice as"command" from"gh-r" \
          atclone"./starship init zsh > init.zsh; ./starship completions zsh > _starship" \
          atpull"%atclone" src"init.zsh"
zinit light starship/starship

###### Remove till Section 1 End if you dont want custom theme or change the url to your custom theme ######
# Check if the custom theme exists, and download if not
if [[ ! -f ~/.config/starship.toml ]]; then
    curl -fsSL https://raw.githubusercontent.com/knightfury16/dotfiles/master/.config/starship.toml -o ~/.config/starship.toml
fi

# Ensure Starship uses the downloaded theme
STARSHIP_CONFIG=~/.config/starship.toml
###### Section 1 End ######

# Load zsh plugins via zinit
zinit light zsh-users/zsh-syntax-highlighting    # Syntax highlighting for commands
zinit light zsh-users/zsh-completions            # Additional completion definitions
zinit light zsh-users/zsh-autosuggestions        # Fish-like autosuggestions
zinit ice from"gh-r" as"program"                 # Install fzf from GitHub releases
zinit light junegunn/fzf
zinit light Aloxaf/fzf-tab                       # Tab completion with fzf

# Install zoxide (smart cd command) via zinit
zinit ice as"command" from"gh-r" \
         atclone"./zoxide init zsh > init.zsh" \
         atpull"%atclone" src"init.zsh" \
         pick"zoxide"
zinit light ajeetdsouza/zoxide

# Load completions (order of the below two line matter)
autoload -Uz compinit && compinit -C            # Initialize the completion system
zinit cdreplay -q                               # Apply all compdef calls that zinit has collected

# Keybindings start
bindkey -e                             # Enable Emacs keybindings 
bindkey '^p' history-search-backward   # Ctrl+p to search history backward
bindkey '^n' history-search-forward    # Ctrl+n to search history forward
bindkey '^[w' kill-region              # Alt+w to kill region (cut text)
bindkey '^f' autosuggest-accept        # Ctrl+f to accept autosuggestion

# History settings
HISTSIZE=2000                          # Number of commands to keep in memory
HISTFILE=~/.zsh_history                # History file location
SAVEHIST=$HISTSIZE                     # Number of commands to save to disk
HISTDUP=erase                          # Delete duplicate commands from history
setopt appendhistory                   # Append to history file rather than overwrite
setopt sharehistory                    # Share history among all sessions
setopt hist_ignore_space               # Don't save commands that start with space
setopt hist_ignore_all_dups            # Don't save duplicate commands
setopt hist_save_no_dups               # Don't write duplicate commands to history file
setopt hist_ignore_dups                # Don't save duplicate commands in a row
setopt hist_find_no_dups               # Don't display duplicates when searching

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'  # Case-insensitive matching
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}" # Colored completion menu
zstyle ':completion:*' menu no                          # No menu selection
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'    # Preview for cd completion
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'  # Preview for zoxide

# Aliases section start
alias ls='ls --color'                 # Colorized ls output
alias ll='ls -al --color'             # Long listing with hidden files
alias vim='nvim'                       # Use neovim instead of vim
# Add color to grep commands
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
# Quick directory navigation
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
# List only directories
alias lsd='ls -d --color=auto */'
# List with human-readable file sizes
alias lh='ls -lh --color=auto'
# File size sorting
alias lt='ls -lhtr --color=auto'  # Sort by time, reverse
alias lS='ls -lhS --color=auto'   # Sort by size
# Quick find commands
alias ff='find . -type f -name'
alias fd='find . -type d -name'
# System info shortcuts
alias dfh='df -h'  # Disk usage in human-readable format
alias duh='du -h'  # Directory usage in human-readable format
alias free='free -h'  # Memory usage in human-readable format
alias llg='ll | grep '
# Process management
alias psg='ps aux | grep -v grep | grep -i'  # Process search
# Quick edit of common config files
alias ez='$EDITOR ~/.zshrc'
alias sz='source ~/.zshrc'  # Reload zsh config
# Alias for maintaining dotfiles repo
alias config="git --git-dir=$HOME/.dotfiles --work-tree=$HOME"
# Git Aliases
source ~/.git-aliases                  # Load git aliases from separate file

# Aliases section end

# Exports section start
export PATH="$PATH:/Users/suhaibknight/.dotnet/tools"  # Add .NET tools to PATH
export EDITOR="nvim"                                   # Set default editor to neovim
export DOTNET_ROOT=$(dirname $(which dotnet))
# Exports section end

# Shell integrations start
eval "$(fzf --zsh)"                   # Enable fzf shell integration
eval "$(zoxide init zsh)"            # Initialize zoxide
# Shell integrations end
