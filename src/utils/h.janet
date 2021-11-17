(defmacro for
  "kinda like `for` in Clojure."
  [binding & body]
  ~(map (fn [val]
          (let [,(first binding) val]
            ,(splice body)))
        ,(get binding 1)))
# (h/for [x [{:a 1} {:a 2}]] (get x :a)) #=> @[1 2]

(defn assoc-one
  [table-or-struct k v]
  (-> table-or-struct
      (freeze)
      (kvs)
      (splice)
      (table)
      (put k v)
      (freeze)))
# (assoc-one  {:a 1 :b 2} :c 3) #=> {:a 1 :b 2 :c 3}
# (assoc-one @{:a 1 :b 2} :c 3) #=> {:a 1 :b 2 :c 3}

(defn dissoc-one
  [table-or-struct k]
  (assoc-one table-or-struct k nil))
# (dissoc-one  {:a 1 :b 2} :b) #=> {:a 1}
# (dissoc-one @{:a 1 :b 2} :b) #=> {:a 1}


(defn contains-key?
  "Returns true if hashmap `hm` contains key `k`. Otherwise, returns false."
  [hm k]
  (->> (keys hm)
       (index-of k)
       (number?)))


(defn keywordise-hm-keys
  ``
  Changes {"a" 1 "b" 2} to {:a 1 :b 2}.

  NOTE: probably doesn't work with nested values yet.
  ``
  [json-object]
  (->> json-object
    (keys)
    (map (fn [k]
           {(keyword k) (get json-object k)}))
    (apply merge)))
# (keywordise-hm-keys {"a" 1 "b" 2}) #=> @{:a 1 :b 2}



(defn ->kebab-case
  ``
  Transforms snake_case keywords in a hashmap to kebab-case.

  NOTE: currently only one level, no nested transforming.
  ``
  [hm]
  (if (nil? hm)
    nil
    (->> hm
      (keys)
      (map (fn [k]
             (let [new-k (->> k
                           (string)
                           (string/replace-all "_" "-")
                           (keyword))]
               {new-k (get hm k)})))
      (apply merge))))
# (->kebab-case {:value_a 1 :value_b 2}) #=> @{:value-a 1 :value-b 2}


(defn conj
  [xs x]
  (-> xs
      (freeze)
      (splice)
      (tuple x)))
# (conj [1 2 3] 4) # =>  (1 2 3 4)
