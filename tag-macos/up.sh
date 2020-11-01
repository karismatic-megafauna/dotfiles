#!/usr/bin/env bash

set -euo pipefail

dotfiles="$HOME/.dotfiles"
tag="macos"

# ---

_review() {
  local install_file
  install_file="$1"
  local yn
  echo -e "=====\nPlease review $install_file before continuing:\n=====\n"
  cat "$install_file" && echo -ne "\n-----\nExecute $install_file [yN]? " && read -r yn

  shopt -s nocasematch
  if ! [[ $yn =~ (y|yes) ]]; then
    >&2 echo -e "\n=> Aborting (chose not to execute $install_file)\n"
    exit 1
  fi
}

_ensure_brew_installed() {
  if type brew; then return 0; fi # skip if brew installed

  local install_file
  install_file="$(mktemp)"
  curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install > "install_file"

  _review "$install_file"

  if ! /usr/bin/ruby "$install_file"; then
    >&2 echo 'Failure installing Homebrew... See: https://brew.sh'
    exit 1
  fi

  rm "$install_file"
}

_ensure_brew_deps_installed() {
  local brewfile="$dotfiles/tag-$tag/Brewfile"

  if ! brew bundle check --file="$brewfile"; then
    brew bundle install --verbose --no-upgrade --file="$brewfile"
  fi

  brew update --verbose && brew outdated --verbose
}

_ensure_omz_installed() {
  if [ -d "$HOME/.oh-my-zsh" ]; then return 0; fi # skip if omz installed

  local install_file
  install_file="$(mktemp)"
  # NOTE: the pipe to sed here is to prevent install.sh from starting a new
  #       login shell on us, which prevents anything after this from being run.
  curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh \
    | sed -e 's/env\ zsh\ \-l//g' \
    > "$install_file"

  _review "$install_file"

  if ! sh "$install_file"; then
    >&2 echo 'Failure installing Oh My Zsh... See: https://ohmyz.sh/'
    exit 1
  fi

  rm "$install_file"
}

main() {
  _ensure_brew_installed
  _ensure_brew_deps_installed
  _ensure_omz_installed

  export RCRC="$dotfiles/rcrc" && rcup -v -d "$dotfiles" -t "$tag"
}

# ---

main
