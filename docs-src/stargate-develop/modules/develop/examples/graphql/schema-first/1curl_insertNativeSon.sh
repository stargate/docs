curl --location --request POST '{base_url}{base_gql_api}/{gkeyspace}' \
--header "X-Cassandra-Token: {auth_token}" \
--header 'Content-Type: application/json' \
--data-raw '{"query":"mutation insertnativeson {\n  insertBook(book: { title: \"Native Son\", author: \"Richard Wright\" }) {\n    title\n  }\n}\n","variables":{}}'
