(use /src/routes/route-paths)

(import /deps/dotenv)

(import /src/db/db)
(import /src/db/db-helper)
(import /src/routes/home)
(import /src/utils/h)
(import /src/utils/html-utils)
(import /src/utils/password-utils)
(import /src/utils/session-utils)


(def- error-message-4XX "Incorrect combination of email address and password.")
(def- error-message-5XX "Something went wrong. Please try again later.")
(def- request-body-email-address-keyword :email-address)
(def- request-body-password-keyword :password)


(defn- unacceptable-credentials?
  [email-address password]
  (let [unacceptable?
        # TODO
        false]
    unacceptable?))


(defn HANDLER
  [request]
  (try
    (let [body
          (get request :body)

          {request-body-email-address-keyword request-email
           request-body-password-keyword request-password}
          body

          bad-request?
          (unacceptable-credentials?
            request-email
            request-password)

          db-user-response
          (unless bad-request?
            (try
              (->
                (db-helper/qualified-kebab-query
                  db/select-user-by-email-address
                  {:=user/email-address request-email}))
              ([err fib]
               (errorf "Something went wrong while fetching the user. Probably the supplied email address %q does not exist. Error: %q" request-email err)
               nil)))

          _ (printf "db-user-response: %q" db-user-response)
          bad-request?
          (or bad-request?
              (nil? db-user-response)
              (not= 1 (length db-user-response)))

          =user
          (unless bad-request?
            (first db-user-response))

          bad-request?
          (or bad-request?
              (nil? =user))

          {:=user/id =user/id
           :=user/password =user/password}
          =user

          bad-request?
          (or bad-request?
              (nil? =user/id))

          _
          (unless bad-request?
            (when (nil? =user/password)
              (errorf "DB contains no password for user '%s'" request-email)))

          request-credentials-correct?
          (unless bad-request?
            (password-utils/correct-password?
              request-password
              =user/password))

          bad-request?
          (or bad-request?
              (not request-credentials-correct?))

          set-cookie-header
          (unless bad-request?
            (let [session-token
                  (session-utils/create-session
                    # TODO:
                    #  - store the session token in the DB
                    #  - in the auth middleware, get the stored session token from the DB, and verify it matches the one in the request
                    {:=user/id =user/id})]

              # TODO: add cookie attributes if needed - https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Set-Cookie#syntax
              {"Set-Cookie" (string "session-token=" session-token)}))]
      (if bad-request?
        (html-utils/bad-request-error-response error-message-4XX)
        (html-utils/OK-response-with-headers
          [:div {:hx-post >>/home
                 :hx-trigger "load"}
           "Redirecting..."]
          set-cookie-header)))

    ([err fib]
     (printf "Error: %q" err)
     (html-utils/internal-error-response
       error-message-5XX))))
