(use /src/routes/route-paths)

(import /lib/html)
(import /lib/tw)
(import /src/utils/twu)


(def htmx-version "1.6.0")


(defn create-html5-page
  ``
  Returns an html5 page.
   Inputs:
   - title:      Page title, shown when hovering the browser tab, e.g.
   - navbar:     A Hiccup datastructure resembling the navigation bar.
   - content:    A Hiccup datastructure resembling the content of the page.
   - csrf-token: A CSRF (a.k.a XSRF) token.
  ``
  [title navbar content csrf-token]
  (html/html
    (html/doctype :html5)
    [:html {:lang "en"}
     [:head
      [:title title]
      [:meta {:name "viewport"
              :content "width=device-width, initial-scale=1.0"}]
      [:meta {:charset "UTF-8"}]

      # Load custom css file
      [:link {:rel "stylesheet"
              :type "text/css"
              :href "./public/css/global.css"}]

      # Explicitly set  tw/style  to the default "" value. I could set this
      # dynamically for each route to only serve the required CSS for each
      # page, but it's probably not going to be a huge amount of CSS in total
      # anyway.
      [:style (tw/style "")]


      # Serve htmx JS scripts (note that "./<etc>" is actually <project root>/public/<etc> because we say so in app-routes.janet)
      [:script {:type "text/javascript" :src (string "./public/js/htmx/" htmx-version "/htmx.min.js")}]
      [:script {:type "text/javascript" :src (string "./public/js/htmx/" htmx-version "/ext/debug.js")}] # TODO: make this dev-only
      [:script {:type "text/javascript" :src (string "./public/js/htmx/" htmx-version "/ext/json-enc.js")}]
      [:script {:type "text/javascript" :src (string "./public/js/htmx/" htmx-version "/ext/include-vals.js")}]

      [:script {:type "text/javascript" :src "./public/js/our-htmx-config.js"}]]
     [:body {:class twu/APP-BACKGROUND-COLOUR} # Seems like we just need anything here, really, to ensure other tailwind classes will be picked up.
      [:div {:id "page-content"
             :class [twu/container twu/mx-auto]}
       navbar
       content]
      # NOTE: it would probably be safer to put the csrf token in a hidden form field and to make the cookie with the token "HttpOnly". Reason: an XSS vulnerability in the current setup gives the attacker access to the token, which they wouln't have with the HttpOnly cookie.
      [:script (html/raw (string "document.body.addEventListener('htmx:configRequest', (event) => { event.detail.headers['X-CSRFToken'] = '" csrf-token "'; })"))]]]))


(defn full-page-OK-response
  [title navbar hiccup-form csrf-token]
  {:status 200
   :headers {"Content-Type" "text/html; charset=utf-8"}
   :body (create-html5-page
           title
           navbar
           hiccup-form
           csrf-token)})

(defn OK-response
  [hiccup-form]
  {:status 200
   # :headers {"Content-Type" "text/html; charset=utf-8"}
   :body (html/html hiccup-form)})

(defn OK-response-with-headers
  [hiccup-form headers-hm]
  {:status 200
   :headers (merge {"Content-Type" "text/html; charset=utf-8"}
                   headers-hm)
   :body (html/html hiccup-form)})

(defn internal-error-response
  [hiccup-form]
  {:status 500
   # :headers {"Content-Type" "text/html; charset=utf-8"}
   :body (html/html hiccup-form)})

(defn bad-request-error-response
  [hiccup-form]
  {:status 400
   # :headers {"Content-Type" "text/html; charset=utf-8"}
   :body (html/html hiccup-form)})


(defn full-page-redirect-response
  [title navbar hiccup-form csrf-token]
  {:status 302
   :headers {"Content-Type" "text/html; charset=utf-8"}
   :body (create-html5-page
           title
           navbar
           hiccup-form
           csrf-token)})
