curl --location --request POST '{base_url}{base_gql_api}/{gkeyspace}' \
--header "X-Cassandra-Token: {auth_token}" \
--header 'Content-Type: application/json' \
--data-raw '{"query":"mutation insertgroundswell2 {\n  insertBook(book: { title: \"Groundswell\", author: \"Katie Lee\" }) {\n    title\n  }\n}\n","variables":{}}'
