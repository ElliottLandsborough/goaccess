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

if [[ ${1:-} == --all-logs ]]; then
  shift
  logs_root=${LOGS_ROOT:-/Users/elliott/Desktop/logs}
  report_file=${REPORT_FILE:-$logs_root/goaccess-all-report.html}
  shopt -s nullglob
  log_files=("$logs_root"/nginx.{1,2,3}/access.log*)
  shopt -u nullglob

  if (( ${#log_files[@]} == 0 )); then
    printf 'No access logs found under %s/nginx.{1,2,3}\n' "$logs_root" >&2
    exit 1
  fi

  printf 'Processing %d access log files...\n' "${#log_files[@]}"
  ./goaccess --log-format=COMBINED --with-output-resolver \
    "${log_files[@]}" --output="$report_file" "$@"
  printf 'HTML report written to %s\n' "$report_file"
  exit
fi

if (( $# == 0 )); then
  log_file=${LOG_FILE:-/Users/elliott/Desktop/logs/nginx.1/access.log-20260721.log}
  report_file=${REPORT_FILE:-/Users/elliott/Desktop/logs/goaccess-report.html}
  set -- "$log_file" --output="$report_file"

  ./goaccess --log-format=COMBINED --with-output-resolver "$@"
  printf 'HTML report written to %s\n' "$report_file"
  exit
fi

exec ./goaccess --log-format=COMBINED --with-output-resolver "$@"