#!/usr/bin/env bash

init () {
  read -rp 'NAME=' name
  read -rp 'VERSION=' version
  read -rp 'DESCRIPTION=' description
  read -rp 'REPOSITORY=' repository
  read -rp 'MAIN=' main
  
  { echo "NAME=${name}";
    echo "VERSION=${version}";
    echo "DESCRIPTION=${description}"; 
    echo "REPOSITORY=${repository}";
    echo "MAIN=${main}"; } > "$(pwd)/.smash"
}

