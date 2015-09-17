alias tmux="TERM=screen-256color-bce tmux"

#ls color
if [ -f "$HOME/.dircolors" ]
  then
    eval $(dircolors -b $HOME/.dircolors)
fi

eval "$(rbenv init -)"

#Aliases in .bash_aliases
if [ -f ~/.bash_aliases ]; then
   . ~/.bash_aliases
fi

# NVM
if [ -s ~/.nvm/nvm.sh ]; then
	NVM_DIR=~/.nvm
	source ~/.nvm/nvm.sh
fi

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
