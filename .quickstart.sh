#!/usr/bin/env bash

# Copy and paste all of the below into a shell.

(

set -euo pipefail

_mktemp() {
  local _dir
  _dir="$(mktemp -d)"
  local -r _file="$_dir/setup.sh"
  touch "$_file"

  echo "$_file"
}

# shellcheck disable=SC2120
_fetch_setup() {
  local -r _repo="${1:-awseward/dotfiles}"
  local -r _quickstart="$(_mktemp)"
  chmod +x "$_quickstart"
  curl -fLo "$_quickstart" "https://raw.githubusercontent.com/$_repo/master/setup.sh"

  echo "$_quickstart"
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

_prompt_review() {
  local -r _file="$1"

  echo -n "Before continuing, please press enter to review $_file "
  # shellcheck disable=SC2034
  read -r _
  less "$_file"
  cat "$_file"
  echo -e "\n---"

  if ! _prompt_yn "Execute $_file" 'n'; then
    2>&1 echo -e "\n=> Aborting (chose not to execute $_file)\n"
    return 1
  fi
}

clear
# shellcheck disable=SC2119
_quickstart="$(_fetch_setup)"
_prompt_review "$_quickstart" && "$_quickstart"

)
