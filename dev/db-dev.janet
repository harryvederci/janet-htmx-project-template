(import /deps/sqlite3 :as sql)
(import /src/utils/h)

(def- db-path "dev/db-dev.sqlite")


(defn insert-request-log
  "Dev only, don't use in production."
  [request]
  (let [db
        (sql/open db-path)

        _creating-db-table-if-necessary
        (sql/eval
          db
          `
          create table if not exists http_request_log (http_request_log_id integer primary key autoincrement, http_request text);
          `)

        _inserting-http-request-log-item
        (sql/eval
          db
          `
          insert into http_request_log (http_request) values (:request);
          `
          {:request (string/format "%q" request)})

        _exited
        (sql/close db)]
    nil))


(defn- q
  "Query anything. UNSAFE, but OK for dev-only things."
  [statement]
  (let [db
        (sql/open db-path)

        result
        (sql/eval db statement)

        _exited
        (sql/close db)]
    (->> result
         (map h/->kebab-case)
         (freeze))))

(defn- qt
  "Query all from table `table-name`. UNSAFE, but OK for dev-only things."
  [table-name]
  (q (string "select * from " table-name ";")))

(comment
  (qt :todo_list)
  (qt :todo_list_item))
