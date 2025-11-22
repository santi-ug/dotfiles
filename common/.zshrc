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
# PATH + OS-SPECIFIC SETTINGS
############################################

# Basic PATH
export PATH="$HOME/bin:$PATH"

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


############################################
# EDITOR
############################################
export EDITOR="nvim"



# Load Angular CLI autocompletion.
source <(ng completion script)
