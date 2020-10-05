#!/usr/bin/env bash

remove_old_version () {
  rm -rf "$(get_package_install_path)"
}

create_new_version () {
  mkdir -p "$(get_package_install_path)"

  # Option cp -T does not exist on Mac
  # therefore we need to handle the differences
  # between different platforms
  {
    # Supress the output if this does not work.
    cp --recursive --no-target-directory "$(pwd)" "$(get_package_install_path)" > /dev/null 2>&1
  } || {
    cp -R "$(pwd)/" "$(get_package_install_path)"
  }

  cp "$(pwd)/.smash" "$(get_package_install_path)/.config"
}

link_package () {
  ln -s "$(get_package_main)" "$(get_script_install_path)"
}

set_permissions () {
  chmod +x "$(get_script_install_path)"
  chmod +x "$(get_package_main)"
}

cleanup_install () {
  clear_cloned
}

install () {

  shift

  # Make sure .smash/bin exists
  if ! [ -d "${HOME}/.smash/bin" ] ; then
    echo "Making directory ${HOME}/.smash/bin"
    mkdir -p "${HOME}/.smash/bin"
  fi

  # If a second argument is passed
  # clone the url and enter into the
  # cloned project assuming it follows
  # the correct smash structure.
  if [ ! $# -eq 0 ]; then
    clear_cloned
    clone_cli_repository "${1}"
    go_to_cloned_repo "$(get_repository_name "${1}")"
  fi
  
  read_config
  echo "Installing ${SMASH_NAME} cli to $(get_script_install_path)"

  remove_old_version
  create_new_version
  link_package
  set_permissions

  trap cleanup_install EXIT
}
