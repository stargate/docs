curl --location --request POST '{base_url}{base_gql_api}/{gkeyspace}' \
--header "X-Cassandra-Token: {auth_token}" \	
--header 'Content-Type: application/json' \
--data-raw '{"query":"# retrieves no books\n# change to author: \"Zorro Doe\" and both books show up\nquery fetchBooksLT {\n  bookLT( title:\"Groundswell\",  author: \"Zorro Doe\") {\n    title\n    isbn\n	author\n  }\n}","variables":{}}'
