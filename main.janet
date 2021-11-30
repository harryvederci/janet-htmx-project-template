(import circlet)
(import dotenv)
(import /lib/tw)
(import /src/middleware/mw-auth)
(import /src/middleware/mw-body)
(import /src/routes/app-routes)
(import /src/utils/h)


(def routes app-routes/routes)
(def port (-> (dotenv/env :port)
              (h/error-when-nil "Please specify a port in your .env file.")
              scan-number))

(defn main
  [& args]
  (tw/tailwind.min.css "./lib/tw/css/tailwind.min.css")
  (circlet/server
    (-> routes
        # NOTE: this is in reverse order: the last one is applied first!
        circlet/router
        mw-auth/auth-checker
        mw-body/body-decoder
        circlet/cookies
        # http-request-db-logger
        circlet/logger)
    port))
