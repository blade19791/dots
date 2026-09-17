# ======================================================
# Zsh configuration with Starship + Fish-like autocomplete
# ======================================================

# ----------------------------------------
# Omarchy environment (OMARCHY_PATH + PATH),
# needed even for non-interactive shells
# ----------------------------------------
[[ -r /usr/share/omarchy/default/bash/env-bootstrap ]] && source /usr/share/omarchy/default/bash/env-bootstrap

# ----------------------------------------
# Starship prompt
# ----------------------------------------
export STARSHIP_CONFIG="$HOME/.config/starship.toml"
eval "$(starship init zsh)"

# ----------------------------------------
# Oh My Zsh setup
# ----------------------------------------
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME=""  # Starship replaces prompt
export ZSH_CUSTOM="$HOME/.oh-my-zsh/custom"

# Standard plugins
plugins=(
  git
  zsh-autosuggestions
  zsh-completions
  zsh-syntax-highlighting
)

# Inline suggestions: prefer completion candidates (commands, tools, files)
# over history only.
ZSH_AUTOSUGGEST_STRATEGY=(completion default)

# Load Oh My Zsh
source $ZSH/oh-my-zsh.sh

# ----------------------------------------
# Completion system (extra)
# ----------------------------------------
autoload -Uz compinit
compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' list-colors ''
setopt AUTO_LIST
setopt AUTO_MENU
setopt COMPLETE_IN_WORD
setopt CORRECT

# ----------------------------------------
# History settings
# ----------------------------------------
HISTFILE=~/.zsh_history
HISTSIZE=5000
SAVEHIST=5000
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_VERIFY

# ----------------------------------------
# Colored output
# ----------------------------------------
autoload -U colors && colors
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced
alias ls='ls --color=auto'

# Colored man pages
man() {
  LESS_TERMCAP_mb=$'\e[1;31m' \
  LESS_TERMCAP_md=$'\e[1;31m' \
  LESS_TERMCAP_me=$'\e[0m' \
  LESS_TERMCAP_se=$'\e[0m' \
  LESS_TERMCAP_so=$'\e[1;44;33m' \
  LESS_TERMCAP_ue=$'\e[0m' \
  LESS_TERMCAP_us=$'\e[1;32m' \
  command man "$@"
}

# ----------------------------------------
# Aliases
# ----------------------------------------
alias clr='clear'
alias ll='ls -la --color=auto'
alias grep='grep --color=auto'
alias zr='source ~/.zshrc'
alias i='yay -S'
alias nv='nvim'

# eza alias
alias el='eza --icons'
alias ell='eza -l --icons'
alias ela='eza --icons -a'
alias ella='eza -la --icons'
alias elt='eza --icons -T'

# Git Aliases
alias g='git'
alias gi='git init'
alias ga='git add'
alias gc='git commit'
alias gcm='git commit -m'
alias gst='git status --short'
alias gl='git log --oneline --graph --decorate --all'
alias gco='git checkout'
alias gb='git branch'
alias gd='git diff'
alias gp='git push'
alias glast='git log -1 HEAD'
alias gcfg='git config --global --list'
alias grv='git remote -v'
alias gcl='git clone'

# ----------------------------------------
# zsh-syntax-highlighting (must be last)
# ----------------------------------------
source $ZSH_CUSTOM/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# ----------------------------------------
# End of configuration
# ----------------------------------------

