curl --location --request POST '{base_url}{base_gql_api}/{gkeyspace}' \
--header "X-Cassandra-Token: {auth_token}" \
--header 'Content-Type: application/json' \
--data-raw '{"query":"mutation insertAnotherBook {\n insertBook(book: { title: \"Pride and Prejudice\", author: \"Jane Austen\" }) {\n      title\n      author\n  }\n}\n","variables":{}}'
