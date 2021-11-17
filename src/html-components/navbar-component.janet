(use /src/routes/route-paths)

(import /src/utils/hxu)

(defn build
  []
  [:div {:class ["noprint"]}
   [:h3 "Welcome"]
   [:button {:hx-post >>/todo-list/get-todo-list-component
             :hx-ext "json-enc,include-vals"
             :data-include-vals (hxu/incl-vals {:todo-list-id 1})
             :hx-target "#page-content"
             :hx-swap "innerHTML"}
    "TODO LIST 1"]])
