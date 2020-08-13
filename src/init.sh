#!/usr/bin/env bash

init () {
  read -rp 'NAME=' name
  echo "NAME=${name}" > '.smash'
}

