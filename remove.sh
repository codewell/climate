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
    echo "climate remove <cli-name>"
    exit 1
  fi

  export CONFIG_NAME="${2}"
  echo "Removing ${CONFIG_NAME} cli"
  remove_files "${CONFIG_NAME}"
  trap 'echo ${CONFIG_NAME} removed' EXIT
}
