(import /deps/json)
(import /src/db/db)
(import /src/db/db-helper)
(import /src/html-components/hc-todo-list)
(import /src/utils/h)
(import /src/utils/html-utils)

(def HANDLER
  (fn [request]
    (let [body
          (-> request (get :body))

          =todo-list/id
          (get body :todo-list-id)

          todo-list
          (->
            (db-helper/qualified-kebab-query
              db/select-todo-list-by-id
              {:=todo-list/id =todo-list/id})
            (h/error-when-nil-or-length-not-exactly-1 (string/format "Expected to get exactly 1 todo list from the DB with id %q" =todo-list/id))
            first)

          todo-list-items
          (->
            (db-helper/qualified-kebab-query
              db/select-todo-list-items-by-todo-list-id
              {:=todo-list/id =todo-list/id}))

          # _ (printf "todo-list-items: %q" todo-list-items)

          todo-list-with-items
          (merge
            todo-list
            {:=todo-list-item++ todo-list-items})

          response-content
          (hc-todo-list/build todo-list-with-items)]
      (html-utils/OK-response response-content))))
