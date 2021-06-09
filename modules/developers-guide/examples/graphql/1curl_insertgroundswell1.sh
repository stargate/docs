curl --location --request POST '{base_url}{base_gql_api}/{gkeyspace}' \
--header "X-Cassandra-Token: {auth_token}" \
--header 'Content-Type: application/json' \
--data-raw '{"query":"mutation insertgroundswell1 {\n  insertBook(book: { title: \"Groundswell\", author: \"Charlene Li\" }) {\n    title\n  }\n}\n","variables":{}}'
