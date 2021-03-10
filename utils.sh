#!/usr/bin/env bash

get_script_install_path () {
  echo "${package_bin}/${CONFIG_NAME}"
}

get_package_install_path () {
  echo "${package_install_path}/${CONFIG_NAME}"
}

get_package_main () {
  echo "$(get_package_install_path)/${CONFIG_MAIN}"
}

required_field () {
  if [[ -z $1 ]]; then
    echo "Required field ${2} is missing in .${package_name}"
    read -rp "${2}=" value
    echo "${2}=${value}" >> ".${package_name}"
    export "CONFIG_${2}=${value}"
  fi
}

recommended_field () {
  if [[ -z $1 ]]; then
    echo "Recommended field ${2} is missing in .${package_name}"
    echo "${3}"
  fi
}

validate_config () {
  required_field "${CONFIG_NAME:-}" "NAME"
  required_field "${CONFIG_MAIN:-}" "MAIN"
  required_field "${CONFIG_VERSION:-}" "VERSION"
  required_field "${CONFIG_DESCRIPTION:-}" "DESCRIPTION"
  recommended_field "${CONFIG_REPOSITORY:-}" "REPOSITORY" " - \"${package_name} update\" will not be available"
}

get_config_file_path () {
  echo "$(pwd)/.${package_name}"
}

read_config () {
  if [ -f "$(get_config_file_path)" ]; then
    while IFS= read -r line; do
      export "CONFIG_${line?}"
    done < "$(get_config_file_path)"
    validate_config
  else
    echo ".${package_name} file is missing"
    exit 1
  fi
}

# Not really relative but...
relative_path () {
  echo "$(dirname "${BASH_SOURCE[0]}")/${1}"
}

get_repository_name () {
  # Get the slug of the url "foo.git"
  slug=${1##*/}

  # Trim the .git part
  repository_name=${slug%.*}
  echo "${repository_name}"
}

get_config_field () {
  grep "${2}=" < "${package_base}/packages/${1}/.${package_name}" | cut -d= -f2
}

clone_cli_repository () {
  ( cd "${package_clones_path}" &&
    git clone "${1}" ) || exit
}

go_to_cloned_repo () {
  cd "${package_clones_path}/${1}" || exit
}

clear_clones () {
  rm -rf "${package_clones_path:?}"/*
}
