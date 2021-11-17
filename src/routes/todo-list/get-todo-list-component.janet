(import /deps/json)
(import /src/db/db-select)
(import /src/html-components/todo-list-component)
(import /src/utils/h)
(import /src/utils/html-utils)

(def HANDLER
  (fn [request]
    (let [body
          (-> request (get :body) json/decode h/keywordise-hm-keys)

          todo-list-id
          (get body :todo-list-id)

          todo-list
          (db-select/todo-list-by-id todo-list-id)

          response-content
          (todo-list-component/build todo-list)]
      (html-utils/OK-response response-content))))
