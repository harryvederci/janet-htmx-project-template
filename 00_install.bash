#!/usr/bin/env bash

# set -x # Print commands and their arguments as they are executed.
set -e # Exit immediately if a command exits with a non-zero status.


#
# If you're as paranoid as the author about your life's work depending on the
# availability of some code on a random computer on the internet, you can
# remove the "/dependencies" line in the .gitignore file.
#



dir_of_this_file="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

target_dir=${dir_of_this_file}/dependencies

case "$(uname -s)" in
  Darwin) target_dir=${target_dir}/macos ;;
  Linux)  target_dir=${target_dir}/linux ;;
  *)      echo "Please add a $(uname -s) config to this script and try again."; exit 1 ;;
esac

rm deps || true # remove (if exists) symlink "deps" --> ./dependencies/<operating system name>
ln -s ${target_dir} deps # create    symlink "deps" --> ./dependencies/<operating system name>






rm -rf ${target_dir}
mkdir -p ${target_dir}/.cache

echo "Installing dependencies to ${target_dir}"
JANET_PATH=${target_dir} jpm deps

for directory in ${target_dir}/.cache/*/; do
  cat <<EOF > ${directory}/GIT_REPO_INFO.txt
Original repo:
  $(git --git-dir=${directory}/.git remote -v | head -n 1)

Latest commit:
  $(git --git-dir=${directory}/.git log --oneline | head -n 1)
EOF

  rm -rf ${directory}/.git
done


rm deps || true # remove (if exists) symlink "deps" --> ./dependencies/<operating system name>
ln -s ${target_dir} deps # create    symlink "deps" --> ./dependencies/<operating system name>
