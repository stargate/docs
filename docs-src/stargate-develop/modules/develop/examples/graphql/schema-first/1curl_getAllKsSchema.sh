curl --location --request POST '{base_url}{base_gql_admin}' \
--header "X-Cassandra-Token: {auth_token}" \
--header 'Content-Type: application/json' \
--data-raw '{"query":"{\n  schemas(keyspace: \"library\") {\n    version\n    deployDate\n    contents\n  }\n}\n","variables":{}}'
