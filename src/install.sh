#!/usr/bin/env bash

remove_old_version () {
  rm -rf "$(get_package_install_path)"
}

create_new_version () {
  mkdir -p "$(get_package_install_path)"
  cp -r "$(pwd)/src/" "$(get_package_install_path)"
  cp "$(pwd)/.smash" "$(get_package_install_path)/.config"
}

write_script_file () {
cat > "$(get_script_install_path)" <<EOF
#!/usr/bin/env bash
set -o errexit -o pipefail -o nounset
$(get_package_main) \$@
EOF
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
  write_script_file
  set_permissions

  trap cleanup_install EXIT
}
