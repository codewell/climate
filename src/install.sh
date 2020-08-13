#!/usr/bin/env bash

remove_old_version () {
  rm -rf "$(get_package_install_path)"
}

create_new_version () {
  mkdir -p "$(get_package_install_path)"
  cp -r "$(pwd)/src/" "$(get_package_install_path)"
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

cleanup () {
  echo "Done"
}


install () {

  shift

  # If a second argument is passed 
  # clone the url and enter into the
  # cloned project assuming it follows
  # the correct smash structure.
  if [ ! $# -eq 0 ]; then
    git clone "$1" &&
    repo_name="$(get_repository_name "${1}")" &&
    cd "${repo_name}" || exit
  fi
  
  read_config
  echo "Installing ${SMASH_NAME} cli to $(get_script_install_path)"

  remove_old_version
  create_new_version
  write_script_file
  set_permissions

  # If cloned from a repo we should remove
  # the cloned files after installation
  if [ ! $# -eq 0 ]; then
    ( cd .. && 
      rm -rf "${repo_name}" )
  fi

  trap cleanup EXIT
}
