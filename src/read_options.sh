#!/usr/bin/env bash

help_message () {
  cat "$(relative_path "help.txt")"
}

read_options () {
  if [ $# -eq 0 ]; then
      help_message
  else
    while test $# -gt 0; do
      case "$1" in
        help)
          help_message
          exit 0
          ;;
        install)
          install "$@"
          exit 0
          ;;
        init)
          init
          exit 0
          ;;
        *)
          help_message
          break
          ;;
      esac
    done
  fi
}
