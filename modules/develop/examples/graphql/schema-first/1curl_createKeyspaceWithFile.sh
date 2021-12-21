curl -X POST '{base_url}{base_gql_schema}' \
-H "x-cassandra-token: {auth_token}" \
-H 'Content-Type: application/json' \
-d @createKeyspace.json
