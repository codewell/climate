#!/usr/bin/env bash
set -o errexit -o pipefail -o nounset

get_template_path () {
  echo "$(dirname "${BASH_SOURCE[0]}")/boilerplate/${1}"
}

project_file_path () {
  echo "$(pwd)/${project_name}/${1}"
}

create_template () {
  cat "$(get_template_path "${1}")" > "$(project_file_path "${2}")"
}

create_smash_file () {
cat > "$(pwd)/${project_name}/.climate" <<EOF
NAME=${project_name}
VERSION=0.1.0
REPOSITORY=
MAIN=main
DESCRIPTION=New SMASH project
EOF
}

boilerplate () {
  # Create a new diretory
  project_name="${2:-"new-smash-cli"}"
  mkdir "$(pwd)/${project_name}"
  
  create_smash_file
  create_template "main.template" "main"
  create_template "help_message.template" "help_message.sh"
  create_template "help.txt.template" "help.txt"
  create_template "read_args.template" "read_args.sh"
  create_template "read_options.template" "read_options.sh"
  create_template "utils.template" "utils.sh"

}
