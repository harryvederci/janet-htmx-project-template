(import /deps/dotenv)
(import /lib/cipher)


(defn create-encryption-key
  ``
  Only use me once, and put me in a .env file as the ENCRYPTION_KEY.
  ``
  []
  # TODO: find out what the difference is between this and cipher/password-key
  (cipher/encryption-key))


(defn create-password-key
  ``
  Only use me once, and put me in a .env file as the PASSWORD_KEY.
  (Unless you want to make all existing user passwords useless.)
  ``
  []
  (cipher/password-key))


(defn hash-password
  [password]
  (let [password-key (dotenv/env :password-key)
        new-password (cipher/hash-password password-key password)]
    new-password))


(defn correct-password?
  [plaintext-password hashed-password]
  (let [password-key (dotenv/env :password-key)]
    (cipher/verify-password
      password-key
      hashed-password
      plaintext-password)))


# (correct-password? "password" (hash-password "password")) # => true
# (correct-password? "bla"      (hash-password "password")) # => false
