# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH

  autoload -Uz compinit
  compinit
fi

###
# oh-my-zsh configs
###

export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="powerlevel10k/powerlevel10k"
DEFAULT_USER=$USER

COMPLETION_WAITING_DOTS="true"
# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

plugins=(git zsh-autosuggestions zsh-z)

source $ZSH/oh-my-zsh.sh

echo -e "\n. $(brew --prefix asdf)/asdf.sh" >> ~/.zshrc

###
# custom configs
###

# use vim as visual editor
export VISUAL=vim
export EDITOR=$VISUAL

# aliases
[[ -f ~/.aliases ]] && source ~/.aliases

# FZF
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# export FZF_DEFAULT_COMMAND='ag -g ""'
# export FZF_DEFAULT_COMMAND='rg --files --hidden --no-ignore-vcs'
# set -gx FZF_DEFAULT_COMMAND  'rg --files --no-ignore-vcs --hidden'
export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --no-ignore-vcs -g "!{node_modules,.git,yarn.lock,tmp}"'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# Fix bracketed paste mode issue
if [[ $TERM = dumb ]]; then
  unset zle_bracketed_paste
fi

# PostgreSQL
export PATH="/usr/local/opt/postgresql@9.6/bin:$PATH"

# Better history
# Credits to https://coderwall.com/p/jpj_6q/zsh-better-history-searching-with-arrow-keys
# autoload -U up-line-or-beginning-search
# autoload -U down-line-or-beginning-search
# zle -N up-line-or-beginning-search
# zle -N down-line-or-beginning-search
# bindkey "^K" up-line-or-beginning-search # Up
# bindkey "^B" down-line-or-beginning-search # Down
bindkey "^l" autosuggest-accept

#To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

g_repo() {
  local repo
  # repo="$(find -H "$HOME/Code" -type d -name '.git' -print | fzf --height 25% --reverse --border --header='Repositories:')"
  # repo="$(find -H "$HOME/Code" -type d -or -type l -not -path '*/node_modules/*' | fzf --height 25% --reverse --border --header='Repositories:')"
  # repo="$(find -H "$HOME/Code" -type d -or -type l \( -path node_modules \) -prune -o -print | fzf --height 25% --reverse --border --header='Repositories:')"
  repo="$(find -H "$HOME/Code/Procore/procore/hydra_clients" "$HOME/Code/Procore/core-labs" -maxdepth 2 -type d -or -type l | fzf --height 25% --reverse --border --header='Repositories:')"
  if [ "$repo" != '' ]; then
    cd "$repo" && pwd && l
  fi
}

g_branch() {
  local branches
  branches=$(git branch -a | sed -E 's/remotes\/[^\/]*\///g; /(\*|HEAD).*$/d' | sort -u | awk '{$1=$1};1')
  local branch
  branch="$(echo "$branches" | fzf --height 25% --reverse --border --header='Branches:')"

  if [ "$branch" != '' ]; then
    git checkout "$branch"
  fi
}

# (jr for 'Jump to Repo')
#
# NOTE: This assumes a convention of repositories being located in:
#       `$HOME/projects/$LANG_OR_CONTEXT/`
_keybind_g_repo() {
  g_repo
  zle reset-prompt
}
zle -N _keybind_g_repo && bindkey '^j^r' _keybind_g_repo

# (gh not for any real reason other than making it work)
#
# I wanted to use jb or gb for 'Jump to Branch' or `Git Branch', but neither
# of those wanted to work. TODO: Figure out exactly why that is.
_keybind_g_branch() {
  g_branch
  zle reset-prompt
}

zle -N _keybind_g_branch && bindkey '^g^g' _keybind_g_branch

. /usr/local/opt/asdf/asdf.sh

. /usr/local/opt/asdf/asdf.sh
