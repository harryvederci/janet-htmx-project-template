(defn remove-routes-path-prefix
  "Turns ./src/routes/a/b/c into /a/b/c (e.g.)
   (Note that it keeps a prefix '/' intentionally.)"
  [path]
  (let [routes-path-prefix
        "./src/routes"

        prefix-slice
        (string/slice path 0 (length routes-path-prefix))

        has-routes-path-prefix?
        (= routes-path-prefix prefix-slice)

        _
        (unless has-routes-path-prefix?
          (error (string "File '" path "' does not start with '" routes-path-prefix "'")))

        without-prefix
        (string/slice path (length routes-path-prefix))]
    without-prefix))
# TODO: create test: (remove-routes-path-prefix "./src/routes/a/b/c") # -> "/a/b/c"

(defn strip-janet-extension
  [path]
  (let [janet-extension-slice-amount
        -7

        janet-extension?
        (= ".janet" (string/slice path janet-extension-slice-amount))]
    (if janet-extension?
      (string/slice path 0 janet-extension-slice-amount)
      (error (string "File '" path "' does not end with '.janet'")))))

(defn relative-path-to-current-file
  "Returns the relative path to the current file.
  (Relative from the standpoint of where Janet was started.)"
  []
  (let [absolute-path-to-cwd
        (os/cwd)

        path-to-this-file
        (dyn :current-file)]
    (string/slice path-to-this-file (length absolute-path-to-cwd))))

(defn get-route-for-current-file
  "NOTE: looks like this function behaves differently when called from the REPL."
  [path-to-calling-file-relative-to-project-root]
  (->> path-to-calling-file-relative-to-project-root
      (string/split "src/routes")
      last
      strip-janet-extension))
