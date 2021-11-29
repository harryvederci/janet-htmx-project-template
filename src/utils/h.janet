(import /deps/json)

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
  Transforms a hashmap with snake_case keys into a hashmap with kebab-case keys. 

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


(defn ->snake-case
  ``
  Transforms a hashmap with kebab-case keys into a hashmap with snake_case keys. 

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
                           (string/replace-all "-" "_")
                           (keyword))]
               {new-k (get hm k)})))
      (apply merge))))
# (->snake-case {:value-a 1 :valuebb 2}) #=> @{:value_a 1 :value_b 2}

(defn conj
  [xs x]
  (-> xs
      (freeze)
      (splice)
      (tuple x)))
# (conj [1 2 3] 4) # =>  (1 2 3 4)


(defn call-or-map
  ``
  If `value` is nil:
    returns nil.
  If `value` is a list:
    maps `f` over `value`.
  Else:
    calls `f` with `value` as its parameter.
  ``
  [f value]
  (cond
    (nil? value)
    nil

    (dictionary? value)
    (f value)

    true # TODO: check if it's really a list (/ whatever iterable stuff is called in Janet).
    (map f value)))


(defn json-body->janet
  "Gets the (json) body from an http request, and converts it into Janet data."
  [json-body]
  (if (and json-body (not (empty? json-body)))
    (-> json-body
      json/decode
      keywordise-hm-keys)
    {}))

(defn error-when-fn-applied-to-value-not-falsy
  "Useful for throwing exceptions in thread-first (->) macros."
  [value condition-fn error-string]
  (if (condition-fn value)
    (error error-string)
    value))

(defn error-when-nil
  [value error-string]
  (error-when-fn-applied-to-value-not-falsy
    value
    nil?
    error-string))

(defn error-when-length-not-exactly-1
  [value error-string]
  (error-when-fn-applied-to-value-not-falsy
    value
    (fn [xs] (not= 1 (length xs)))
    error-string))

(defn error-when-nil-or-length-not-exactly-1
  [value error-string]
  (error-when-fn-applied-to-value-not-falsy
    value
    (fn [xs] (or (nil? xs) (not= 1 (length xs))))
    error-string))



# (comment)
#   (->>)
#     (h/for [x (pairs {:a 1 :b 2})])
#       x
#     (map (fn [bla] {(first bla) (last bla)}))
