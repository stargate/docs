curl --location --request POST '{base_url}{base_gql_api}/{gkeyspace}' \
--header "X-Cassandra-Token: {auth_token}" \	
--header 'Content-Type: application/json' \
--data-raw '{"query":"query fetchBooksIn {\n  booksIn(title:[\"Native Son\", \"Moby Dick\"]) {\n      title\n      author\n  }\n}","variables":{}}'
