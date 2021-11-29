(use /src/routes/route-paths)

(import /src/utils/twu)

(defn build
  []
  [:div {:class [twu/flex-1
                 twu/p-2
                 twu/m-2
                 twu/border
                 twu/rounded-lg
                 twu/text-center
                 twu/border-light-blue-500]}
   [:h2 {:class [twu/font-semibold
                 twu/text-lg
                 twu/text-center
                 twu/m-2]}
    "Login"]
   [:br]
   [:form {:hx-post >>/user-login
           :hx-target "body"
           :hx-ext "json-enc"}
    [:div
     [:label {:for "email-address"}
      "Email address"]]
    [:div
     [:input {:type "text"
              :placeholder "email-address"
              :class [twu/INPUT-FIELD
                      twu/m-2]
              :name "email-address"
              :required true}]]

    [:br]

    [:div
     [:label {:for "password"}
      "Password"]]
    [:div
     [:input {:type "password"
              :placeholder "password"
              :class [twu/INPUT-FIELD
                      twu/m-2]
              :name "password"
              :required true}]]
    [:div
     [:button {:type "submit"
               :class [twu/bg-blue-400
                       twu/text-white
                       twu/text-base
                       twu/px-2
                       twu/m-2
                       twu/rounded-md]}
      "Login"]]]])
