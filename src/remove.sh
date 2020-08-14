#!/usr/bin/env bash

remove_files () {
  rm -rf "$(get_script_install_path)"
  rm -rf "$(get_package_install_path)"
}

remove () {
  # If a second argument is not passed
  # then we don't know what package to remove
  if [ ! $# -eq 2 ]; then
    echo "We need to know the name of the package!"
    echo "Usage:"
    echo "smash remove <cli-name>"
    exit 1
  fi

  export SMASH_NAME="${2}"
  echo "Removing ${SMASH_NAME} cli"
  remove_files "${SMASH_NAME}"
  trap 'echo ${SMASH_NAME} removed' EXIT
}
