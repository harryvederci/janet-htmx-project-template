(import /src/utils/h)

(defn- qualified-snake-case->qualified-kebab-case
  ``
  IN:
    {:table_name__column_name 1}
  OUT:
    {:=table-name/column-name 1}
  ``
  [hm]
  (if (nil? hm)
    nil
    (->> hm
      (keys)
      (map (fn [k]
             (let [new-k (->> k
                           (string "=")
                           # TODO: error if no "__" found
                           (string/replace "__" "/")
                           (string/replace-all "_" "-")
                           (keyword))]
               {new-k (get hm k)})))
      (apply merge))))
# (qualified-snake-case->qualified-kebab-case {:table_name__column-name 1}) # => @{:=table-name/column-name 1}


(defn- qualified-kebab-case->qualified-snake-case
  ``
  IN:
    {:=table-name/column-name 1}
  OUT:
    {:table_name__column_name 1}
  ``
  [hm]
  (if (nil? hm)
    nil
    (->> hm
      (keys)
      (map (fn [k]
             (let [new-k (->> k
                           (string)
                           # TODO: error if no "=" found
                           (string/replace "=" "")
                           # TODO: error if no "/" found
                           (string/replace "/" "__")
                           (string/replace-all "-" "_")
                           (keyword))]
               {new-k (get hm k)})))
      (apply merge))))
# (qualified-kebab-case->qualified-snake-case {:=table-name/column-name 1}) # => @{:table_name__column_name 1}


(defn kebab-query
  "Converts `input` into snake_case so sql won't be mad.
  Then queries the db using a suresql-generated function `db-fn`.
  Then converts the db query result into kebab-case."
  [db-fn input]
  (-> input
      h/->snake-case
      db-fn
      h/->kebab-case))


(defn qualified-kebab-query
  "Converts qualified/kebab-case formatted `input` into qualified__snake_case.
  Then queries the db using a suresql-generated function `db-fn`.
  Then converts the db query result into qualified-kebab-case.

  (Read the descriptions of this file its qualified-*->qualified* functions to
  understand what this is about.)"
  [db-fn input]
  (printf "\nSQL - input: %q" input)
  (try
    (-> input
        qualified-kebab-case->qualified-snake-case
        db-fn
        (->> (h/call-or-map
               qualified-snake-case->qualified-kebab-case)))
    ([err fib]
     (printf "Something went wrong there. Could be due to a mapping error, or due to the query failing. Error: %q" err)
     (error err))))
