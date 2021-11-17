(use /src/routes/route-paths)

(import /src/utils/hxu)
(import /src/html-components/todo-item-checkbox-component)
(import /src/html-components/todo-item-text-component)

(defn build
  [todo-list-id todo-list-item]
  (let [{:todo-list-item-id todo-list-item-id
         :todo-list-item-checked todo-list-item-checked
         :todo-list-item-text todo-list-item-text}
        todo-list-item]
    [:div
     # (string/format "%p - %p" todo-list-id todo-list-item)
     (todo-item-checkbox-component/build todo-list-item)
     (todo-item-text-component/build todo-list-item)]))
