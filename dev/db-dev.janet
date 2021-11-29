(import /deps/sqlite3)
(import /src/db/db)
(import /src/db/db-helper)

(defn migrate-and-seed
  []
  (def db (sqlite3/open db/db-path))
  (slurp db/db-path)
  (->> "dev/db-migrate-1-up.sql" slurp string (sqlite3/eval db))
  (->> "dev/db-dev-seed-1.sql" slurp string (sqlite3/eval db))
  (sqlite3/close db)
  nil)
(comment
  (migrate-and-seed))


(comment
  (db-helper/qualified-kebab-query
    db/select-user
    {:=user/email-address "mail@example.com"})
  # => @[@{:=user/email-address "mail@example.com" :=user/id 1}]


  nil)
