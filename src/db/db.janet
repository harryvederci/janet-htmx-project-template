(import /deps/sqlite3)
(import /lib/suresql)

(def db-path "dev/db-dev.sqlite")

(defn defquery-with-same-name-as-file
  [sql-file &opt options]
  (let [queries (->> (slurp sql-file)
                     (suresql/parse-queries))
        connection (get options :connection)]

    (if (not= 1 (length queries))
      (errorf "File '%p' should contain only one SQL statement.")
      (let [q
            (first queries)

            name # TODO: this does not ensure unique file names, I guess defglobal will overwrite duplicates.
            (->> sql-file
              (string/split ".sql")
              (first)
              (string/split "/")
              (last))]
        (defglobal (symbol name) (suresql/query-fn connection q name))))))

(defn- generate-suresql-queries-for-all-files-in-dir
  [dir]
  (each file-or-dir (os/dir dir)
    (let [relative-path
          (string dir "/" file-or-dir)

          kind
          (os/stat relative-path :mode)]
      (case kind
        :directory
        (errorf
          "Found a directory in %p.
          For now, all suresql sql files should be in the (non-nested) dir '%p'.
          Either change the generate-suresql-queries-for-all-files-in-dir function, or move the file."
          dir
          dir)
          

        :file
        (do
          (printf "Creating suresql query for file: %p" relative-path)
          (defquery-with-same-name-as-file
            relative-path
            {:connection (sqlite3/open db-path)}))

        (errorf
          "Unexpected file type '%p' encountered while generating sql queries."
          kind)))))

(generate-suresql-queries-for-all-files-in-dir "src/db/suresql")

# (defquery-with-same-name-as-file)
#   "src/db/suresql/select-users-where.sql"
#   {:connection (sqlite3/open db-path)}
