(import /test/th :exit true)

(defn create-and-run-route-handler-test
  ```
  Example arguments:
    - input-handler
        get-todo-list/HANDLER
    - input
        {:body (json/encode {:todo-list-id 1})}
    - expected-output-status-code
        200
    - path-to-file-with-expected-output
        "/test/routes/todo-list/get-todo-list/1_output.html"
  ```
  [input-handler
   input
   expected-output-status-code
   path-to-file-with-expected-output]
  (let [expected-output-body
        (-> path-to-file-with-expected-output
            slurp
            string
            # Trim trailing \n from file content. (Assumes you always add that. TODO: Maybe make this optional..?)
            (string/slice 0 -2))

        {:status actual-output-status
         :body actual-output-body}
        (input-handler input)]
    (th/is (= expected-output-status-code actual-output-status))

    (th/is (= expected-output-body actual-output-body))))
