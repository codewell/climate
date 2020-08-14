#!/usr/bin/env bash

init () {
  read -rp 'NAME=' name
  read -rp 'VERSION=' version
  read -rp 'DESCRIPTION=' description
  read -rp 'REPOSITORY=' repository
  read -rp 'MAIN=' main
  
  echo "NAME=${name}" > '.smash'
  echo "VERSION=${version}" >> '.smash'
  echo "DESCRIPTION=${description}" > '.smash'
  echo "REPOSITORY=${repository}" > '.smash'
  echo "MAIN=${main}" > '.smash'
}

