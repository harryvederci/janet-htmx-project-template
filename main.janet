(import /deps/circlet)
(import /dev/db-dev)
(import /src/routes/app-routes)
(import /src/routes/route-paths)


(def routes app-routes/routes)




#
# TODO: make this configurable
#
(def store-all-requests-in-db? false)




(defn http-request-db-logger
  "If `store-all-requests-in-db?` is true, this middleware stores every
  incoming request in the database. Don't be a freak and track your users like
  this..
  Example of an OK use case: let a friend test your application, log their
  interactions, and use the logged http requests to generate a test from their
  interactions.  Since it's a friend, you'll tell them you're recording their
  actions, right?  And you won't do anything nasty with their data, right?!

  (The `nextmw` parameter is the handler function of the next middleware)"
  [nextmw]
  (fn [req]
    (def ret (nextmw req))
    (when (true? store-all-requests-in-db?)
      # TODO: try/catch?
      # TODO: make input safe for db?
      (db-dev/insert-request-log req))
    ret))

(defn main
  [& args]
  (let [port
        9001]
    (circlet/server
      (-> routes
          circlet/router
          http-request-db-logger
          circlet/logger)
      port)))
