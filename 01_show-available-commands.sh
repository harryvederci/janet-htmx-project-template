echo "Run   jpm run   with one of the following inputs:"

grep '(phony' project.janet \
  | sed -E 's/^.{6}//'
