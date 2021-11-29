(import /src/utils/h)

(defn body-decoder
  ``
  If the request method is not "GET", convert the request body from JSON to a
  Janet datastructure.

  (The `nextmw` parameter is the handler function of the next middleware)
  ``
  [nextmw]
  (fn [req]
    (if (= "GET"
           (get req :method))
      (nextmw req))
    # TODO:
    #  - only do json decoding if url is legit (= one of our existing routes)
    #  - maybe also create a SCHEMA (next to the HANDLER) for each route, and
    #    return a 404 response if the incoming data structure does not match
    #    that.
    (let [body
          (get req :body)

          altered-body
          (h/json-body->janet body)

          altered-req
          (put req :body altered-body)]
      (nextmw altered-req))))
