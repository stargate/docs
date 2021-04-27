curl --location --request POST '{base_url}{base_gql_admin}' \
--header "X-Cassandra-Token: {auth_token}" \
--header 'Content-Type: application/json' \
--data-raw '{"query":"{\n  schema(keyspace: \"library\", version: "01a00a50-9e50-11eb-8fde-b341b9f82ca9") {\n    version\n    deployDate\n    contents\n  }\n}\n","variables":{}}'
