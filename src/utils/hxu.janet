(defn target-helper
  ```
  - I: :div "new-project"
  - O: {:id                       "new-project-placeholder"
        :target                   "#new-project-placeholder"
        :empty-placeholder-html   [:div {:id "new-project-placeholder"}]}
  ```
  [placeholder-html-element-type wrapped-id-string]
  (let [id
        (string wrapped-id-string "-placeholder")

        id-as-target
        (string "#" id)

        result
        {:id                       id
         :target                   id-as-target
         :empty-placeholder-html   [placeholder-html-element-type {:id id}]}

        result-keys
        (-> result
            keys
            freeze)]

    (fn [input-key]
      (let [valid-input-key?
            (some (partial = input-key) result-keys)]
        (if valid-input-key?
          (get result input-key)
          (error "Unsupported input key specified to the hxu/target-helper function."))))))


(defn target-id
  ```
  Prefixes an html element id with "#".
  - I: "some-html-id"
  - O: "#some-html-id"
  ```

  [html-element-id]
  (string "#" html-element-id))

(defn incl-vals
  ```
  Converts a struct (hashmap) to a properly formatted string
  for the htmx 'include-vals' plugin.

  Use this to make your life easier when providing
  a :data-include-vals htmx attribute.

  NOTE: When using this, make sure you also provide
  a :hx-ext attribute with a value containing 'include-vals',
  i.e.  :hx-ext "json-enc,include-vals"
  ```
  [data-include-vals-hm]
  (-> data-include-vals-hm
      (pairs)
      (->> (map (fn [[x y]]
                  (if (or (= :boolean (type y))
                          # TODO: can any other types be used without surrounding quotes?
                          (= :number (type y)))
                    (string "'" x "': " y)
                    (string "'" x "': " "'" y "'")))))
      (string/join ", ")))
# (incl-vals {:a "bla" :b 2}) #=> "'a': 'bla', 'b': 2"
