###
# oh-my-zsh configs
###

export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="kolo"
DEFAULT_USER=$USER

COMPLETION_WAITING_DOTS="true"

plugins=(git zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh

###
# custom configs
###

# use vim as visual editor
export VISUAL=vim
export EDITOR=$VISUAL

# aliases
[[ -f ~/.aliases ]] && source ~/.aliases

# # NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


# FZF
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# export FZF_DEFAULT_COMMAND='ag -g ""'
# export FZF_DEFAULT_COMMAND='rg --files --hidden --smartcase --glob "!.git/*"'
# set -gx FZF_DEFAULT_COMMAND  'rg --files --no-ignore-vcs --hidden'
export FZF_DEFAULT_COMMAND='rg --files --no-ignore-vcs --hidden'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# Fix bracketed paste mode issue
if [[ $TERM = dumb ]]; then
  unset zle_bracketed_paste
fi

# PostgreSQL
export PATH="/usr/local/opt/postgresql@9.6/bin:$PATH"

# export PATH="/usr/local/rbenv/bin:$PATH"
# export PATH="$PATH/.rbenv/shims:$PATH"

# export RBENV_ROOT="/usr/local/rbenv"
eval "$(rbenv init - )"

# Better history
# Credits to https://coderwall.com/p/jpj_6q/zsh-better-history-searching-with-arrow-keys
# autoload -U up-line-or-beginning-search
# autoload -U down-line-or-beginning-search
# zle -N up-line-or-beginning-search
# zle -N down-line-or-beginning-search
# bindkey "^K" up-line-or-beginning-search # Up
# bindkey "^B" down-line-or-beginning-search # Down
bindkey "^l" autosuggest-accept
export HOMEBREW_GITHUB_API_TOKEN=526d8a095f268bc6556ff6896858f9b3a9d317e0
