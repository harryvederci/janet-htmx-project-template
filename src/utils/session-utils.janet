(import /deps/dotenv)
(import /deps/http)
(import /lib/cipher)


(defn- safe-unmarshal [val]
  (unless (or (nil? val) (empty? val))
    (unmarshal val)))


(defn- decrypt-session [key str]
  (when (string? str)
    (try
      (cipher/decrypt key str)
      ([err]
       (unless (= err "decryption failed")
         (error err))))))


(defn- decode-session-with-key [key str]
  (when (and (string? str)
             (truthy? key))
    (as-> str ?
          (decrypt-session key ?)
          (safe-unmarshal ?))))
(comment
  (decode-session-with-key
    (dotenv/env :encryption-key)
    "763c8f6e423c461300cb83a9666a78d45d8c489746f1d1a4d64ecd82f8c748e53edc21eb15b64efb855fb0e101ade9bfec"))


(defn decode-session [session-string]
  (try
    (decode-session-with-key
      (dotenv/env :encryption-key)
      session-string)
    ([err fib]
     (printf "Could not decode session. Error: %q" err)
     nil)))


(defn- encode-session [val key]
  (when (truthy? key)
    (->> (marshal val)
         (string)
         (cipher/encrypt key))))


# (defn- session-from-request [key request])
#   (-> (get request :cookies))
#       (get "id")
#       (decode-session key)


(defn create-session
  [input]
  # TODO: throw error if input is nil or empty
  (let [key
        (dotenv/env :encryption-key)

        # TODO: throw error if key is nil or empty

        result
        # TODO: throw error if result is nil or empty
        (encode-session input (dotenv/env :encryption-key))]
    result))
(comment (create-session {:=user/id 1}))
(comment (dotenv/env :environment))
(comment (dotenv/env :port))


(defn cookie-string [name value options]
  (string name "=" value `; `
    (string/join
      (map (fn [[k v]]
             (if (empty? v)
               (string k)
               (string k "=" v)))
        (pairs options))
      "; ")))
