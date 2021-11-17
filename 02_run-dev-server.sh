echo "NOTE: you'll have to manually kill these processes yourself, when done"

set -ex

jpm run dev-browser-auto-refresh &
jpm run dev-server &
