#!/usr/bin/env bash

set -euo pipefail

cd -- "$(dirname -- "${BASH_SOURCE[0]}")"

if [[ ! -f configure ]]; then
  autoreconf -fiv
fi

if [[ ! -f Makefile ]]; then
  ./configure --enable-utf8
fi

make -j"${JOBS:-4}"

if (( $# == 0 )); then
  set -- --version
fi

exec ./goaccess "$@"