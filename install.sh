#!/usr/bin/env bash
set -o errexit -o pipefail -o nounset

mkdir -p "${HOME}/.smash/bin"
bash src/main install

