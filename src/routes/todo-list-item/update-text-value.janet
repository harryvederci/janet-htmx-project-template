(import /deps/json)
(import /src/db/db-update)
(import /src/html-components/todo-item-text-component)
(import /src/utils/h)
(import /src/utils/html-utils)

(def HANDLER
  (fn [request]
    (let [body
          (-> request (get :body) json/decode h/keywordise-hm-keys)

          _ (pp body)

          {:todo-list-item-id todo-list-item-id
           :todo-list-item-text todo-list-item-text}
          body

          todo-list-item
          (db-update/todo-list-item-text-value
            todo-list-item-id
            todo-list-item-text)

          response-content
          (todo-item-text-component/build todo-list-item)]
      (html-utils/OK-response response-content))))
