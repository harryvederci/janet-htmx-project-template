(use /src/routes/route-paths)

(import ./home)
(import /src/utils/file-path-utils)

(var route-handler-mapping @{})

(defn- import-route-path-file-and-add-route-handler-kv-to-mapping
  [path-with-dot-prefix]
  (let [path
        (string/slice path-with-dot-prefix 1)

        k
        (file-path-utils/remove-routes-path-prefix path-with-dot-prefix)]
    # (pp path) (pp k) (print "")
    (when (and
            (not= path "/src/routes/app-routes")
            (not= path "/src/routes/route-paths"))
      (eval-string (string "(import " path " :as " path ")"))
      (set route-handler-mapping
           (merge route-handler-mapping
                  {k (eval-string (string path "/HANDLER"))})))))

(def routes-dir routes-dir) # = defined in route.paths.janet (so not really needed here, just wanted to make it explicit)
(defn- import-all-routes-and-create-route-handler-mappings # TODO: refactor this and /src/routes/route-paths/generate-defs-for-all-routes
  [dir]
  (each file-or-dir (os/dir dir)
    (let [relative-path
          (string dir "/" file-or-dir)

          kind
          (os/stat relative-path :mode)]
      (case kind
        :directory (import-all-routes-and-create-route-handler-mappings relative-path)
        :file (do
                # (print (string "Creating route for '" relative-path "'"))
                (-> relative-path
                    file-path-utils/strip-janet-extension
                    import-route-path-file-and-add-route-handler-kv-to-mapping))
        (error (string "Unexpected file type '" kind "' encountered while generating routes."))))))

(def routes
  (do
    (import-all-routes-and-create-route-handler-mappings routes-dir)
    # (pp route-handler-mapping)
    (merge
      {"" home/HANDLER
       "/" home/HANDLER}
      route-handler-mapping
      {:default {:kind :static
                 :root "./public"}})))
