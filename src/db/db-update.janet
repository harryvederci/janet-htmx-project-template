(import /deps/sqlite3 :as sql)
(import /src/utils/h)

(def db-path "dev/db-dev.sqlite")

(defn todo-list-item-checked-value
  [todo-list-item-id todo-list-item-checked]
  (let [db
        (sql/open db-path)

        result
        (-> 
          (sql/eval db
                    ``
                    update todo_list_item
                    set todo_list_item_checked = :todo_list_item_checked
                    where todo_list_item_id = :todo_list_item_id
                    returning *
                    ;
                    ``
                    {:todo_list_item_id todo-list-item-id
                     :todo_list_item_checked todo-list-item-checked})
          (first)
          (h/->kebab-case))

        _exited
        (sql/close db)]
    result))
(comment
  (todo-list-item-checked-value 1 0))


(defn todo-list-item-text-value
  [todo-list-item-id todo-list-item-text]
  (let [db
        (sql/open db-path)

        result
        (-> 
          (sql/eval db
                    ``
                    update todo_list_item
                    set todo_list_item_text = :todo_list_item_text
                    where todo_list_item_id = :todo_list_item_id
                    returning *
                    ;
                    ``
                    {:todo_list_item_id todo-list-item-id
                     :todo_list_item_text todo-list-item-text})
          (first)
          (h/->kebab-case))

        _exited
        (sql/close db)]
    result))
(comment
  (todo-list-item-text-value 1 "my new todo item text"))
