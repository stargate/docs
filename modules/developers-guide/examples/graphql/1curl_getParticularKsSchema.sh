curl --location --request POST '{base_url}{base_gql_admin}' \
--header "X-Cassandra-Token: {auth_token}" \
--header 'Content-Type: application/json' \
--data-raw '{"query":"{\n  schema(keyspace: \"library\", version: "1da4f190-b7fd-11eb-8258-1ff1380eaff5") {\n    version\n    deployDate\n    contents\n  }\n}\n","variables":{}}'
