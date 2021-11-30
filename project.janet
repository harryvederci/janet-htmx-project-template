(declare-project
  :name
  "janet-htmx-project-template"

  :description
  "Some boilerplate code, to easily create Janet + HTMX projects. Heavily opiniated about its http routes."

  :dependencies
  [# joy-framework/dotenv = to get environment variables from the <project-root>/.env file.
   "https://github.com/joy-framework/dotenv"

   # janet-lang/jhydro = needed for swlkr his cipher library (= in the lib directory, used to generate encryption keys)
   "https://github.com/janet-lang/jhydro"

   # janet-lang/circlet = GPLv2 / COMMERCIAL LICENSED http server.
   "https://github.com/janet-lang/circlet"

   # janet-lang/json = Encodes and Decodes JSON data and converts it to and from Janet data structures. Note: JSON null becomes the keyword :null.
   "https://github.com/janet-lang/json"

   # janet-lang/path = needed for swlkr his tailwind library (= in the lib directory)
   "https://github.com/janet-lang/path"

   # janet-lang/sqlite3 = janet bindings for sqlite.
   # "https://github.com/janet-lang/sqlite3"
   "https://github.com/harryvederci/sqlite3"

   # joy-framework/http = an http client library.
   # NOTE: joy-framework/http requires an OS-level dependency:
   #  - debian/debian-like:       sudo apt install -y libcurl4-openssl-dev
   #  - fedora/centos/rhel-like:  sudo dnf install libcurl-devel
   "https://github.com/joy-framework/http"])




#
# NOTE: make sure you run these commands (with `jpm run <command>`) from the
# directory containing this (project.janet) file.
#


# Start the server by running `jpm run server`
(phony "server"
  []
  (os/shell "jpm -l janet main.janet"))

# Start an nrepl client that Conjure (a Neovim plugin) can connect to.
(phony "dev-repl-conjure"
  []
  (os/shell "janet -e \"(import spork/netrepl) (netrepl/server)\""))

# Same as dev-repl-conjure, but it will run in the background so make sure you
# stop that process manually yourself.
(phony "dev-repl-conjure-background"
  []
  (os/shell "janet -e \"(import spork/netrepl) (netrepl/server)\" &"))

# Start the server in dev mode (auto restarting on each .janet file change)
# by running `jpm run dev-server`
(phony "dev-server"
  []
  (os/shell "find . -name '*.janet' | entr -r jpm -l janet main.janet"))


(declare-executable
  # jpm is smart enough to figure out from the one entry file what libraries
  # and other code your executable depends on, and bundles them into the final
  # application for you.
  # The final executable will be located at ./build/<:name>
  # Also note that the entry of an executable file should look different than a
  # normal Janet script. It should define a main function that can receive a
  # variable number of parameters, the command-line arguments. It will be
  # called as the entry point to your executable.
  :name "janet-htmx-project-template"
  :entry "main.janet")
