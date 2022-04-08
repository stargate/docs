curl --location --request POST '{base_url}{base_gql_api}/{gkeyspace}' \
--header "X-Cassandra-Token: {auth_token}" \
--header 'Content-Type: application/json' \
--data-raw '{"query":"mutation deletepap {\n  deleteBook(book: { title:\"Pride and Prejudice\"})\n}\n","variables":{}}'
