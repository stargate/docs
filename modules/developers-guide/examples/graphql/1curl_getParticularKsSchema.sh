curl --location --request POST '{base_url}{base_gql_admin}' \
--header "X-Cassandra-Token: {auth_token}" \
--header 'Content-Type: application/json' \
--data-raw '{"query":"{\n  schema(keyspace: \"library\", version: "4faadde0-b829-11eb-82d7-2d54f9ed2277") {\n    version\n    deployDate\n    contents\n  }\n}\n","variables":{}}'
