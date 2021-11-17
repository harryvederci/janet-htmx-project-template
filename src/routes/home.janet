(use /src/routes/route-paths)

(import /src/html-components/navbar-component)
(import /src/utils/html-utils)


(defn- build-home-page
  []
  [:div
   [:p
    "TODO: change this into a login page."]])


(defn HANDLER
  [& args]
  (let []
    @{:status 200
      :headers {"Content-Type" "text/html"}
      :body (html-utils/create-html5-page
              "janet-htmx-project-template - home"
              (navbar-component/build)
              (build-home-page))}))
