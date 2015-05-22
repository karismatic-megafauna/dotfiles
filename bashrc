
#Prompt settigns
export PS1="\u@\[\e[36m\]\h\[\e[0m\] :: \w >> "

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

export NVM_DIR="/home/vagrant/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm


# NVM
if [ -s ~/.nvm/nvm.sh ]; then
	NVM_DIR=~/.nvm
	source ~/.nvm/nvm.sh
fi