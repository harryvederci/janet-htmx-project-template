(defn HANDLER
  [request]
  {:status 500
   # :headers {"Content-Type" "text/html; charset=utf-8"}
   :body "TODO - auth.janet handler"})

## TODO: something like this:
#
# htmx:configRequest (https://htmx.org/events/#htmx:configRequest)
#
# document.body.addEventListener('htmx:configRequest', function(evt) {})
#     evt.detail.parameters['auth_token'] = getAuthToken(); // add a new parameter into the mix
# ;
