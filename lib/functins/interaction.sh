#!/usr/bin/env bash

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
