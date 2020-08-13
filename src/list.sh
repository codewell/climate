#!/usr/bin/env bash

get_description () {
  description="$(grep "DESCRIPTION=" < "${HOME}/.smash/${1}/.config" | cut -d= -f2)"
  echo "- ${description:-"Description missing :("}"
}

# List all installded scripts
list () {
  for cli in "${HOME}"/.smash/bin/*; do
    cli_name="$(basename "${cli}")"
    basename "${cli_name} $(get_description "${cli_name}")"
  done
}
