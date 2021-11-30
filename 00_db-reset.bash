#!/usr/bin/env bash

set -x # Print commands and their arguments as they are executed.
set -e # Exit immediately if a command exits with a non-zero status.

dir_of_this_file="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
db_file=${dir_of_this_file}/dev/db-dev.sqlite

rm ${db_file} || true
touch ${db_file}

jpm -l janet -e "(import /dev/db-dev) (db-dev/migrate-and-seed)"
