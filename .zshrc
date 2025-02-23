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

