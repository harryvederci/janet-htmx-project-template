(use /src/routes/route-paths)

(import /src/utils/hxu)

(defn build
  [todo-list-item]
  (let [{:todo-list-item-id todo-list-item-id
         :todo-list-item-text todo-list-item-text}
        todo-list-item] 
    [:input {:type "text"
             :name "todo-list-item-text"
             :value todo-list-item-text
             :hx-post >>/todo-list-item/update-text-value
             :hx-trigger "keyup changed delay:500ms"
             :hx-target "this"
             :hx-swap "outerHTML"
             :hx-ext "json-enc,include-vals"
             :data-include-vals (hxu/incl-vals {:todo-list-item-id todo-list-item-id})}]))
