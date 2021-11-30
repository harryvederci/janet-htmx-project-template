(use /src/routes/app-routes)
(import /src/routes/app-routes)
(import /src/utils/h)
(import json)
(import /test/th :exit true)
(import /test/route-test-helper)

(def all-routes app-routes/routes)
(def route-keys (-> all-routes
                    (h/dissoc-one :default) # Do not try to find tests for the circlet :default router key.  Example value belonging to that key:   {:kind :static :root "./public"}
                    (keys)))


(h/for [route-key route-keys]
  # Example of a route-key: "/todo-list/get-todo-list"
  # (A route-key maps to a `HANDLER` function - the example route-key would map to /src/routes/todo-list/get-todo-list.janet its `HANDLER` function.)
  (let [route-HANDLER-fn
        (get all-routes route-key)

        test-files-dir-path
        (string "test/routes" route-key)

        test-files-os-dir
        (try
          (os/dir test-files-dir-path)
          ([err]
           (do
             (printf
               "\nWARNING:\n  You need to create a test files directory for route %p.\n  Suggested bash command:\n    mkdir -p %p\n"
               route-key
               test-files-dir-path)
             [])))

        _printing-error-message-if-dir-is-empty
        (when (empty? test-files-os-dir)
          (printf "\nWARNING:\n  You need to create test files in the test directory for route %p.\n  If that directory does not exist, you should see a suggested command above this warning.\n" route-key))]

    (each file-or-dir test-files-os-dir
      (let [relative-path
            (string test-files-dir-path "/" file-or-dir)

            kind
            (os/stat relative-path :mode)]
        (when (= :file kind)
          (if (string/has-suffix? "input-body.edn" file-or-dir)
              (let [input-body
                    {:body (-> (string test-files-dir-path "/" file-or-dir)
                               slurp
                               eval-string
                               json/encode)}

                    _throw-error-if-input-body-is-empty
                    (when (= (freeze input-body) {:body "null"})
                      (errorf "Please add an input body to %p" relative-path))

                    expected-status-code-file
                    (string
                      test-files-dir-path
                      "/"
                      (-> (string/split "input-body.edn" file-or-dir)
                          first
                          (string "expected-status-code.txt")))

                    expected-status-code
                    (->
                      expected-status-code-file
                      slurp
                      (->> (string/split "\n"))
                      first
                      scan-number)

                    _throw-error-if-expected-status-code-is-empty
                    (when (nil? (freeze expected-status-code))
                      (errorf "Please add an expected status code to %p" expected-status-code-file))
                    
                    expected-output-body
                    (string
                      test-files-dir-path
                      "/"
                      (-> (string/split "input-body.edn" file-or-dir)
                          first
                          (string "expected-output-body.html")))

                    test-description-file
                    (string
                      test-files-dir-path
                      "/"
                      (-> (string/split "input-body.edn" file-or-dir)
                          first
                          (string "test-description.txt")))

                    test-description
                    (->
                      test-description-file
                      slurp)

                    _throw-error-if-test-description-is-empty
                    (when (= "" (freeze test-description))
                      (errorf "Please add a test description to %p" test-description-file))]



                (th/deftest nil
                  (route-test-helper/create-and-run-route-handler-test
                    # TODO: specify a DB seed file  -  i.e. 1_db-seed-file-reference.txt  -  that specifies the path to an actual DB seed file that must be executed prior to running the test.
                    route-HANDLER-fn
                    input-body
                    expected-status-code
                    expected-output-body))
                (printf "-->> Testing input file: %p" relative-path)
                # (pp (string ">> Description: " test-description))
                (th/run-tests!))
              (if (or (string/has-suffix? "expected-output-body.html" file-or-dir)
                      (string/has-suffix? "expected-status-code.txt" file-or-dir)
                      (string/has-suffix? "test-description.txt" file-or-dir))
                nil
                (printf "\nWARNING:\n  Unexpected test file encountered: %p\n  Note: test files should end with input-body.edn / expected-output-body.html / expected-status-code.txt / test-description.txt\n\n" relative-path))))))))


