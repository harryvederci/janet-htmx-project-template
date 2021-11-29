(import /src/utils/h)
(import /src/html-components/hc-todo-list-item)

(defn build
  [todo-list]
  (let [{:=todo-list/id todo-list-id
         :=todo-list/name todo-list-name
         :=todo-list/description todo-list-description
         :=todo-list-item++ todo-list-items}
        todo-list

        new-todo-list-item-placeholder-helper
        # TODO
        nil]
    [:<>
     # (string/format "%q" todo-list)
     [:h2 todo-list-name]
     [:h3 todo-list-description]
     (if (or (nil? todo-list-items)
             (empty? todo-list))
       [:p "You're all done!(?)"]
       (h/for [item todo-list-items]
          (hc-todo-list-item/build todo-list-id item)))]))
