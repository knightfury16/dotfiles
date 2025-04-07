eval "$(starship init zsh)"

# zsh-autosuggestions settings
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# zsh-syntax highlighting settings
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Load completions
autoload -Uz compinit && compinit

# fzf tab completion
source /Users/suhaibknight/.local/share/fzf-tab/fzf-tab.plugin.zsh

# zoxide - Smart directory hopper
eval "$(zoxide init zsh)"

# Alias for maintaining dotfiles repo
alias config="git --git-dir=$HOME/.dotfiles --work-tree=$HOME"
alias h="cd ~"

# Dotnet tools path
export PATH="$PATH:/Users/suhaibknight/.dotnet/tools"


# setting for *world, press tab to autocomplete to helloWorld
setopt extended_glob



# Yazi editor variable
export EDITOR="nvim"

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# Aliases start
alias ls='ls --color'
alias vim='nvim'

# Git Aliases
source ~/.git-aliases

# Aliases end
#

# Keybind mode 
bindkey -e

# Keybindings start
bindkey '^p' history-search-backward 
bindkey '^n' history-search-forward
bindkey '^f' autosuggest-accept
# Keybindings end



# History settings start
HISTSIZE=5000 # history size
HISTFILE=~/.zsh_history # History file location
SAVEHIST=$HISTSIZE
HISTDUP=erase # Delete duplicate command from history
setopt appendhistory
setopt sharehistory # Share history among all sessions
setopt hist_ignore_space # Add a space before from saving it to history
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups
# History settings end


# Load Angular CLI autocompletion.
source <(ng completion script)

# Shell integrations
eval "$(fzf --zsh)"

