(use /src/routes/route-paths)

(import /src/utils/hxu)

(defn build
  [todo-list-item]
  (let [{:=todo-list-item/id =todo-list-item/id
         :=todo-list-item/checked =todo-list-item/checked}
        todo-list-item]
    [:<>
     # [:div (string/format "%p" todo-list-item)]
     [:input (merge
               (if (= 1 =todo-list-item/checked) {:checked true} {})
               {:type "checkbox"
                :hx-post >>/todo-list-item/update-checked-value
                :hx-target "this"
                :hx-swap "outerHTML"
                :hx-ext "json-enc,include-vals"
                :data-include-vals (hxu/incl-vals {:=todo-list-item/id =todo-list-item/id
                                                   :=todo-list-item/checked (if (= 1 =todo-list-item/checked) 0 1)})})]]))
