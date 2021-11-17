(use /src/routes/route-paths)

(import /lib/html)


(def htmx-version "1.6.0")


(defn create-html5-page
  "Returns an html5 page.
   Inputs:
   - title: Page title, shown when hovering the browser tab, e.g.
   - navbar: A Hiccup datastructure resembling the navigation bar.
   - content: A Hiccup datastructure resembling the content of the page."
  [title navbar content]
  (html/html
    (html/doctype :html5)
    [:html {:lang "en"}
     [:head
      [:title title]
      [:meta {:name "viewport"
              :content "width=device-width, initial-scale=1.0"}]
      [:meta {:charset "UTF-8"}]

      # Load our css file
      [:link {:rel "stylesheet"
              :type "text/css"
              :href "./css/janet-htmx-project-template.css"}]

      # Serve htmx JS scripts (note that "./<etc>" is actually <project root>/public/<etc> because we say so in app-routes.janet)
      [:script {:type "text/javascript" :src (string "./js/htmx/" htmx-version "/htmx.min.js")}]
      [:script {:type "text/javascript" :src (string "./js/htmx/" htmx-version "/ext/debug.js")}] # TODO: make this dev-only
      [:script {:type "text/javascript" :src (string "./js/htmx/" htmx-version "/ext/json-enc.js")}]
      [:script {:type "text/javascript" :src (string "./js/htmx/" htmx-version "/ext/include-vals.js")}]
      [:script {:type "text/javascript" :src "./js/sort-projects.js"}]
      [:script {:type "text/javascript" :src "./js/sort-skills.js"}]]
     [:body
      [:div {:id "page-content"}
       navbar
       content]]]))

(defn OK-response
  [hiccup-form]
  {:status 200
   # :headers {"Content-Type" "text/html; charset=utf-8"}
   :body (html/html hiccup-form)})
