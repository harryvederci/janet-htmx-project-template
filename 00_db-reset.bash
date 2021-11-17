#!/usr/bin/env bash

set -x # Print commands and their arguments as they are executed.
set -e # Exit immediately if a command exits with a non-zero status.

dir_of_this_file="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

db_migration_file=${dir_of_this_file}/dev/db-migrate-1-up.sql
db_seed_file=${dir_of_this_file}/dev/db-dev-seed-1.sql


db_file=${dir_of_this_file}/dev/db-dev.sqlite

rm ${db_file} || true
touch ${db_file}
sqlite3 ${db_file} < "${db_migration_file}"
sqlite3 ${db_file} < "${db_seed_file}"
