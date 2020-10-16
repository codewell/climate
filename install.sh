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

  cp "${config_file_path}" "$(get_package_install_path)/.config"
}

write_script_file () {
cat > "$(get_script_install_path)" <<EOF
#!/usr/bin/env bash
set -o errexit -o pipefail -o nounset
exec $(get_package_main) \$@
EOF
  chmod +x "$(get_script_install_path)"
}

check_permissions () {
	if ! [ -x "$(get_package_main)" ]; then
		echo "WARNING: $(get_package_main) is not executable."
	fi
}

cleanup_install () {
  clear_cloned
}

install () {

  shift

  if ! [ -d "${package_bin}" ] ; then
    echo "Making directory ${package_bin}"
    mkdir -p "${package_bin}"
  fi

  # If a second argument is passed
  # clone the url and enter into the
  # cloned project assuming it follows
  # the correct climate structure.
  if [ ! $# -eq 0 ]; then
    clear_cloned
    clone_cli_repository "${1}"
    go_to_cloned_repo "$(get_repository_name "${1}")"
  fi
  
  read_config
  echo "Installing ${CONFIG_NAME} cli to $(get_script_install_path)"

  remove_old_version
  create_new_version
  write_script_file
  check_permissions

  trap cleanup_install EXIT
}
