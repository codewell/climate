#!/usr/bin/env bash

cleanup_update () {
  # Remove cloned repos
  clear_cloned
}

update () {
  shift
  cli_name="${1}"
  repository="$(get_config_field "${cli_name}" "REPOSITORY")"
  repository_name="$(get_repository_name "${repository}")"
  clear_cloned
  clone_cli_repository "${repository}"
  ( go_to_cloned_repo "${repository_name}" && 
    install "install" )
    
  trap cleanup_update EXIT
}
