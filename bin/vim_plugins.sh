#!/usr/bin/env bash

# manage installed vim plugins
#
# based on minimal safe Bash script template
# https://betterdev.blog/minimal-safe-bash-script-template/

set -Eeuo pipefail
trap cleanup SIGINT SIGTERM ERR EXIT

script_dir=$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd -P)
plugins_dir="$HOME/.vim/pack/plugins/start"

usage() {
  cat <<EOF
Usage: $(basename "${BASH_SOURCE[0]}") [-h] [-v] [-u]

List or upgrade vim plugins

Set -u flag to upgrade all plugins. If no args are given, displays a list
of installed plugins.

Available options:

-h, --help      Print this help and exit
-v, --verbose   Print script debug info
-u, --upgrade   Upgrade installed plugins
EOF
  exit
}

cleanup() {
  trap - SIGINT SIGTERM ERR EXIT
  # script cleanup here
}

setup_colors() {
  if [[ -t 2 ]] && [[ -z "${NO_COLOR-}" ]] && [[ "${TERM-}" != "dumb" ]]; then
    NOFORMAT='\033[0m' RED='\033[0;31m' GREEN='\033[0;32m' ORANGE='\033[0;33m' BLUE='\033[0;34m' PURPLE='\033[0;35m' CYAN='\033[0;36m' BOLDCYAN='\033[1;36m' YELLOW='\033[1;33m'
  else
    NOFORMAT='' RED='' GREEN='' ORANGE='' BLUE='' PURPLE='' CYAN='' BOLDCYAN='' YELLOW=''
  fi
}

msg() {
  echo >&2 -e "${1-}"
}

die() {
  local msg=$1
  local code=${2-1} # default exit status 1
  msg "$msg"
  exit "$code"
}

parse_params() {
  # default values of variables set from params
  upgrade=0

  while :; do
    case "${1-}" in
    -h | --help) usage ;;
    -v | --verbose) set -x ;;
    --no-color) NO_COLOR=1 ;;
    -u | --upgrade) upgrade=1 ;;
    -?*) die "Unknown option: $1" ;;
    *) break ;;
    esac
    shift
  done

  args=("$@")

  # check required params and arguments
  # [[ ${#args[@]} -eq 0 ]] && die "Missing script arguments"

  return 0
}

parse_params "$@"
setup_colors

# script logic here

cd $plugins_dir

plugins=`find . -type d -depth 1`

if [[ $upgrade -eq 1 ]]; then
    for plugin in $plugins
    do
        plugin_name=$(basename $plugin)
        msg "${CYAN}Fetching ${BOLDCYAN}$plugin_name${CYAN}...${NOFORMAT}"
        cd $plugin
        git fetch
        git pull
        cd ..
    done
    msg "${GREEN}Done.${NOFORMAT}"
else
    for plugin in $plugins
    do
        plugin_name=$(basename $plugin)
        msg "$plugin_name"
    done
fi
