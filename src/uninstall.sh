#!/usr/bin/env bash
set -o errexit -o pipefail -o nounset

cleanup () {
  echo "Done!"
}

remove_files () {
  rm -rf "$(get_script_install_path "${1}")"
  rm -rf "${HOME}/.smash/.${1}"
}

uninstall () {
  cli_name="${1}"
  echo "Removing ${cli_name} cli from $(get_script_install_path "${cli_name}")"
  remove_files "${cli_name}"
  trap cleanup EXIT
}
