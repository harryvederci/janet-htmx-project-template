(import /deps/json)
(import /src/db/db-update)
(import /src/html-components/todo-item-checkbox-component)
(import /src/utils/h)
(import /src/utils/html-utils)

(def HANDLER
  (fn [request]
    (let [body
          (-> request (get :body) json/decode h/keywordise-hm-keys)

          _ (pp body)

          {:todo-list-item-id todo-list-item-id
           :todo-list-item-checked todo-list-item-checked}
          body

          todo-list-item
          (db-update/todo-list-item-checked-value
            todo-list-item-id
            todo-list-item-checked)

          response-content
          (todo-item-checkbox-component/build todo-list-item)]
      (html-utils/OK-response response-content))))
