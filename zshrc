###
# oh-my-zsh configs
###

export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="smt"
DEFAULT_USER=$USER

COMPLETION_WAITING_DOTS="true"

plugins=(git)

source $ZSH/oh-my-zsh.sh

###
# custom configs
###

# use vim as visual editor
export VISUAL=vim
export EDITOR=$VISUAL

# aliases
[[ -f ~/.aliases ]] && source ~/.aliases

# NVM
if [ -s ~/.nvm/nvm.sh ]; then
	NVM_DIR=~/.nvm
	source ~/.nvm/nvm.sh
fi

# FZF
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='ag -g ""'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

