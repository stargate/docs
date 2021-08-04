curl --location --request POST '{base_url}{base_gql_api}/{gkeyspace}' \
--header "X-Cassandra-Token: {auth_token}" \
--header 'Content-Type: application/json' \
--data-raw '{"query":"query fetchReadersGT # retrieves only one book, author: Katie Lee\n# change to author: \"Betty Doe\" and both books show up\nquery fetchBooksGT {\n  bookGT( title:\"Groundswell\",  author: \"Betty Doe\") {\n    title\n    isbn\n	author\n  }\n}","variables":{}}'
