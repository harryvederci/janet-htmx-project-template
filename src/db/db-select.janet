(import /deps/sqlite3 :as sql)
(import /src/utils/h)

(def db-path "dev/db-dev.sqlite")

(defn todo-list-by-id
  [todo-list-id]
  (let [db
        (sql/open db-path)

        todo-list
        (-> 
          (sql/eval db
                    ``
                    select * from todo_list where todo_list_id = :todo_list_id
                    ;
                    ``
                    {:todo_list_id todo-list-id})
          (first)
          (h/->kebab-case))

        todo-list-items
        (-> 
          (sql/eval db
                    ``
                    select todo_list_item_id, todo_list_item_text, todo_list_item_checked
                    from todo_list_item where todo_list_id = :todo_list_id
                    ;
                    ``
                    {:todo_list_id todo-list-id})
          (->> (map h/->kebab-case)))

        _exited
        (sql/close db)
        
        result
        (merge todo-list
               {:todo-list-items todo-list-items})]
    result))
