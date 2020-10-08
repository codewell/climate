#!/usr/bin/env bash

get_script_install_path () {
  echo "${HOME}/.climate/bin/${SMASH_NAME}"
}

get_package_install_path () {
  echo "${HOME}/.climate/${SMASH_NAME}"
}

get_package_main () {
  echo "$(get_package_install_path)/${SMASH_MAIN}"
}

required_field () {
  if [[ -z $1 ]]; then
    echo "Required field ${2} is missing in .climate"
    read -rp "${2}=" value
    echo "${2}=${value}" >> '.climate'
    export "SMASH_${2}=${value}"
  fi
}

recommended_field () {
  if [[ -z $1 ]]; then
    echo "Recommended field ${2} is missing in .climate"
    echo "${3}"
  fi
}

validate_config () {
  required_field "${SMASH_NAME:-}" "NAME"
  required_field "${SMASH_MAIN:-}" "MAIN"
  required_field "${SMASH_VERSION:-}" "VERSION"
  required_field "${SMASH_DESCRIPTION:-}" "DESCRIPTION"
  required_field "${SMASH_COMMAND:-}" "COMMAND"
  recommended_field "${SMASH_REPOSITORY:-}" "REPOSITORY" ' - "smash update" will not be available'
}

read_config () {
  smash_file_path="$(pwd)/.climate"
  if [ -f "${smash_file_path}" ]; then
    while IFS= read -r line; do
      export "SMASH_${line?}"
    done < "${smash_file_path}"
    validate_config
  else
    echo ".climate file is missing"
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
  grep "${2}=" < "${HOME}/.climate/${1}/.config" | cut -d= -f2
}

clone_cli_repository () {
  ( mkdir -p "${HOME}/.climate/cloned" &&
    cd "${HOME}/.climate/cloned" &&
    git clone "${1}" ) || exit
}

go_to_cloned_repo () {
  cd "${HOME}/.climate/cloned/${1}" || exit
}

clear_cloned () {
  rm -rf "${HOME}"/.climate/cloned/*
}
