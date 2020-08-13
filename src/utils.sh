#!/usr/bin/env bash

get_script_install_path () {
  echo "${HOME}/.smash/bin/${SMASH_NAME}"
}

get_package_install_path () {
  echo "${HOME}/.smash/${SMASH_NAME}"
}

get_package_main () {
  echo "$(get_package_install_path)/${SMASH_MAIN}"
}

validate_config () {
  if [ -z "$SMASH_NAME" ]; then
    echo "Required field NAME is missing in .smash"
    exit 1
  fi

  if [ -z "$SMASH_MAIN" ]; then
    echo "Required field MAIN is missing in .smash"
    exit 1
  fi
}

read_config () {
  if [ -f '.smash' ]; then
    while IFS= read -r line; do
      export "SMASH_${line?}"
    done < '.smash'
    validate_config
  else
    echo ".smash file is missing"
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
