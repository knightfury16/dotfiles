eval "$(starship init zsh)"

# zsh-autosuggestions settings
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# zoxide - Smart directory hopper
eval "$(zoxide init zsh)"

# Alias for maintaining dotfiles repo
alias config="git --git-dir=$HOME/.dotfiles --work-tree=$HOME"
alias h="cd ~"

# Dotnet tools path
export PATH="$PATH:/Users/suhaibknight/.dotnet/tools"


# setting for *world, press tab to autocomplete to helloWorld
setopt extended_glob


# Git Aliases
source ~/.git-aliases

# Yazi editor variable
export EDITOR="nvim"

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# Load Angular CLI autocompletion.
source <(ng completion script)
