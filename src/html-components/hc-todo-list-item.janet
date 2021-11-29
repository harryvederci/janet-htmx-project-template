(use /src/routes/route-paths)

(import /src/utils/hxu)
(import /src/html-components/hc-todo-item-checkbox)
(import /src/html-components/hc-todo-item-text)

(defn build
  [todo-list-id todo-list-item]
  (let [{:=todo-list-item/id =todo-list-item/id
         :=todo-list-item/checked =todo-list-item/checked
         :=todo-list-item/text =todo-list-item/text}
        todo-list-item]
    [:div
     # (string/format "%p - %p" todo-list-id todo-list-item)
     (hc-todo-item-checkbox/build todo-list-item)
     (hc-todo-item-text/build todo-list-item)]))
