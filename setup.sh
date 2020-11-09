#!/usr/bin/env bash

set -euo pipefail

_warn() {
  >&2 echo "WARNING: $*"
}

_error() {
  >&2 echo "ERROR: $*"
  return 1
}

_prompt_yn() {
  local -r _prompt_txt="$1"
  local -r _default="$2"
  local _yn
  local _opts_hint

  case "$_default" in
    y) _opts_hint=Yn ;;
    n) _opts_hint=yN ;;
    *)
      >&2 echo "Invalid default of '$_default' specified"
      return 1
  esac

  echo -n "$_prompt_txt [$_opts_hint]? " && read -r _yn
  _yn="${_yn:-$_default}"

  if [[ "$(echo -e "$_yn" | tr -d '[:space:]' | tr '[:upper:]' '[:lower:]')" = "y" ]]; then
    return 0
  else
    return 1
  fi
}

[ -z ${HOME+x} ] && export HOME=~
export DOTFILES="${HOME}/.dotfiles"

# NOTE: There's nothing to source here for brand new setups, since the dotfiles
# repo hasn't been cloned yet 🤦...
#
# shellcheck disable=SC1091

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
    git clone git@github.com:karismatic-megafauna/dotfiles.git "${DOTFILES}"
  else
    echo "WARNING: Directory ${DOTFILES} already exists."

    _prompt_yn 'Skip cloning and continue anyway' 'y' || return 1
  fi
}

_up() {
  "${DOTFILES}/tag-${RCM_TAG}/up.sh"
}

_resolve_rcm_tag
_up
