#!/usr/bin/env bash

set -euo pipefail

[ -z ${HOME+x} ] && export HOME=~
export DOTFILES="${HOME}/.dotfiles"

# NOTE: There's nothing to source here for brand new setups, since the dotfiles
# repo hasn't been cloned yet 🤦...
#
# shellcheck disable=SC1091
. lib/functions/interaction.sh

_resolve_rcm_tag() {
  case "${OSTYPE}" in
    darwin*)
      export RCM_TAG=macos
      return 0
    ;;

    # More if necessary...

    *)
      >&2 cat <<ERR

Setup was unable resolve an RCM tag from \${OSTYPE} (which was '${OSTYPE}', by the way).

For more more info on RCM, see: https://github.com/thoughtbot/rcm#readme

ERR
      return 1
    ;;
  esac
}

_clone_repo() {
  if ! [ -d "${DOTFILES}" ]; then
    git clone git@github.com:awseward/dotfiles.git "${DOTFILES}"
  else
    echo "WARNING: Directory ${DOTFILES} already exists."

    _prompt_yn 'Skip cloning and continue anyway' 'y' || return 1
  fi
}

_up() {
  "${DOTFILES}/tag-${RCM_TAG}/up.sh"
}

_resolve_rcm_tag
_clone_repo
_up
