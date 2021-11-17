(import /src/utils/file-path-utils :as file-path-utils)

(def routes-dir "./src/routes") # = from project root

(defn- create-global-route-def-with-route-string-value
  ```
  What:
     Takes a string that represents a route path for this application,
     and creates a symbol for it.

  Why?
    This makes it harder to make mistakes in the application when
    referring to its own routes. In Java you would probably create an Enum
    with all routes, but they probably wouldn't be allowed to contain `/`
    characters. Hip hip, hooray for lispy languages, I guess!

  Example:
    Input:       "/some/route"
    Result:  a  >>/some/route  symbol, whose value is "/some/route" (= the input string)

  Note:
    The output symbol starts with `>>/` instead of just `/`.
    That's not necessary, but it makes it a lot easier to search for
    internally used routes in the application.
  ```
  [route]
  (eval-string (string "(defglobal \">>" route "\" \"" route "\")")))

(defn- generate-defs-for-all-routes
  [dir]
  (each file-or-dir (os/dir dir)
    (let [relative-path
          (string dir "/" file-or-dir)

          kind
          (os/stat relative-path :mode)]
      (case kind
        :directory (generate-defs-for-all-routes relative-path)
        :file (do
                # (print (string "Creating interwebz route for " relative-path))
                (as-> relative-path ___
                      (file-path-utils/remove-routes-path-prefix ___)
                      (file-path-utils/strip-janet-extension ___)
                      (create-global-route-def-with-route-string-value ___)))
        (error (string "Unexpected file type '" kind "' encountered while generating routes."))))))

# TODO: ignore a couple of routes, or move them out of the routes dir to prevent them from being iterated over, maybe.


(generate-defs-for-all-routes routes-dir)
