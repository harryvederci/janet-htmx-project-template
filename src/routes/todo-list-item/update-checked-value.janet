(import json)
(import /src/db/db)
(import /src/db/db-helper)
(import /src/html-components/hc-todo-item-checkbox)
(import /src/utils/h)
(import /src/utils/html-utils)

(def HANDLER
  (fn [request]
    (let [body
          (-> request (get :body))

          _ (pp body)

          {:=todo-list-item/id =todo-list-item/id
           :=todo-list-item/checked =todo-list-item/checked}
          body

          todo-list-item
          (->
            (db-helper/qualified-kebab-query
              db/update-todo-list-item-checked-value
              {:=todo-list-item/id =todo-list-item/id
               :=todo-list-item/checked =todo-list-item/checked})
            (h/error-when-nil-or-length-not-exactly-1 (string/format "Expected to get exactly 1 updated value when updating todo list item with ID %q" =todo-list-item/id))
            first)

          response-content
          (hc-todo-item-checkbox/build todo-list-item)]
      (html-utils/OK-response response-content))))
