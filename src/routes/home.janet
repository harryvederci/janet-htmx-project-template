(use /src/routes/route-paths)

(import /src/html-components/hc-navbar)
(import /src/utils/html-utils)


(defn- build-home-page
  []
  [:div
   [:p
    "TODO"]])


(defn HANDLER
  [& args]
  (let []
    @{:status 200
      :headers {"Content-Type" "text/html"}
      :body (html-utils/create-html5-page
              "janet-htmx-project-template - home"
              (hc-navbar/build)
              (build-home-page)
              nil)}))
