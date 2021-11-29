(import /src/html-components/hc-login)
(import /src/utils/html-utils)
(import /src/utils/session-utils)

(defn- no-login-required?
  ``
  Here you can decide what is and isn't available to anyone.
  For a Proof of Concept application I recently made with this framework, I
  am/was only allowing logged in users to access my app routes, and I opened up
  all "/public/" routes as well.

  You can change this function to receive more than just the request its uri to
  do more fine-grained stuff.
  ``
  [uri]
  (or
    (string/has-prefix? "/public/" uri)
    (= "/user-login" uri)))



(defn auth-checker
  ``
  TODO: write a description of what this does

  (The `nextmw` parameter is the handler function of the next middleware)
  ``
  [nextmw]
  (fn [req]
    (if (no-login-required? (get req :uri))
      (nextmw req)
      (let [{:cookies cookies
             :uri uri
             :headers headers}
            req

            {"X-CSRFToken" csrf-token-from-request-header}
            headers

            {"session-token" session-token}
            cookies

            decoded-session-token
            (when (and cookies
                       (not= {} cookies))
              (session-utils/decode-session session-token))

            =user/id
            (when decoded-session-token
              (get decoded-session-token :=user/id))

            authorised?
            (not (nil? =user/id))]
        (if authorised?
          (let [req-with-decoded-session
                (put req :decoded-session decoded-session-token)]
            (nextmw req-with-decoded-session))
          (do
            (printf "Not authorised. Redirecting to login page.")
            # TODO: ? kill backend session for the session-token, if exists
            (html-utils/full-page-redirect-response
              "login"
              nil
              (hc-login/build)
              "TODO: change me to a proper csrf token")))))))
