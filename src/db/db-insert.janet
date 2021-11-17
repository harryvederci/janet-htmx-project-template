(import /deps/sqlite3 :as sql)
(import /src/utils/h)

(def db-path "dev/db-dev.sqlite")

(defn todo-list
  [todo-list-name todo-list-description]
  (let [db
        (sql/open db-path)

        result
        (sql/eval db
                  ``
                  insert into todo_list (todo_list_name, todo_list_description)
                  values (:todo_list_name, :todo_list_description)
                  returning *
                  ;
                  ``
                  {:todo_list_name  todo-list-name
                   :todo_list_description  todo-list-description})

        _exited
        (sql/close db)]
    (-> result
        (first)
        (h/->kebab-case))))

(defn insert-todo-list-item
  [todo-list-id
   todo-list-item-text
   todo-list-item-checked]
  (let [db
        (sql/open db-path)

        result
        (sql/eval db
                  ``
                  insert into todo_list_item (todo_list_id, todo_list_item_text, todo_list_item_checked)
                  values (:todo_list_id, :todo_list_item_text, :todo_list_item_checked)
                  returning *
                  ;
                  ``
                  {:todo_list_id todo-list-id
                   :todo_list_item_text todo-list-item-text
                   :todo_list_item_checked todo-list-item-checked})

        _exited
        (sql/close db)]
    (-> result
        (first)
        (h/->kebab-case))))
