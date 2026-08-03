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
  log_file=${LOG_FILE:-/Users/elliott/Desktop/logs/nginx.1/access.log-20260721.log}
  report_file=${REPORT_FILE:-/Users/elliott/Desktop/logs/goaccess-report.html}
  set -- "$log_file" --output="$report_file"

  ./goaccess --log-format=COMBINED --with-output-resolver "$@"
  printf 'HTML report written to %s\n' "$report_file"
  exit
fi

exec ./goaccess --log-format=COMBINED --with-output-resolver "$@"