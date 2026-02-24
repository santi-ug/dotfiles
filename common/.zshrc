setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_REDUCE_BLANKS
############################################
# ZINIT INSTALLER (DO NOT TOUCH)
############################################
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

############################################
# COMPLETION SYSTEM (IMPORTANT!)
############################################
# Must come BEFORE anything that uses `compdef`
autoload -Uz compinit
compinit


############################################
# PATH + OS-SPECIFIC SETTINGS
############################################

# Basic PATH
export PATH="$HOME/bin:$PATH"
# User binaries
export PATH="$HOME/.local/bin:$PATH"


# macOS: Homebrew path
if [[ "$OSTYPE" == "darwin"* ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi


############################################
# HISTORY (FULLY IMPROVED)
############################################

HISTFILE="$HOME/.zhistory"
SAVEHIST=100000
HISTSIZE=200000

# Remove duplicates when saving
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_DUPS
setopt HIST_SAVE_NO_DUPS

# Skip duplicates when pressing ↑
setopt HIST_FIND_NO_DUPS

# Clean & strict history
setopt HIST_REDUCE_BLANKS
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_VERIFY
setopt HIST_IGNORE_SPACE

# Share history across sessions
setopt SHARE_HISTORY
setopt INC_APPEND_HISTORY       # append instantly


############################################
# ZINIT PLUGINS
############################################

# Autosuggestions
zinit light zsh-users/zsh-autosuggestions

# Syntax highlighting
zinit light zsh-users/zsh-syntax-highlighting
ZSH_HIGHLIGHT_STYLES[command]='fg=#89b4fa'

# Better completions
zinit light zsh-users/zsh-completions


############################################
# PROMPT (STARSHIP)
############################################
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"

############################################
# ALIASES
############################################
alias c="clear"
alias ll="ls -alF"
alias la="ls -A"
alias l="ls -CF"
alias ll='eza -laah --smart-group --git --time-style=long-iso'

############################################
# FZF
############################################
[[ -f ~/.fzf.zsh ]] && source ~/.fzf.zsh

# Enhanced fzf history search
export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --border"
bindkey '^R' fzf-history-widget

eunrar() {
  f="$1"
  d="${f%.rar}"
  mkdir -p "$d"
  unrar x "$f" "$d"
}

vol() {
  wpctl set-volume @DEFAULT_AUDIO_SINK@ "$@"
}

############################################
# EDITOR
############################################
export EDITOR="nvim"



# Load Angular CLI autocompletion.
# source <(ng completion script)

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

############################################
# NODE / NVM
############################################
export NVM_DIR="$HOME/.nvm"

# Load nvm
[ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"

# (Optional) bash-style completion used by nvm
[ -s "$NVM_DIR/bash_completion" ] && source "$NVM_DIR/bash_completion"

############################################
# PYENV
############################################
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
