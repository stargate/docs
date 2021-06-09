curl --location --request POST '{base_url}{base_gql_api}/{gkeyspace}' \
--header "X-Cassandra-Token: {auth_token}" \
--header 'Content-Type: application/json' \
--data-raw '{"query":"query fetchReadersGT {\n  readerGT( name:\"Herman Melville\",  user_id: \"e0ec47e1-2b46-41ad-961c-70e6de629800\" ) {\n    name\n    user_id\n    birthdate\n  }\n}","variables":{}}'
