curl --location --request POST '{base_url}{base_gql_api}/{gkeyspace}' \
--header "X-Cassandra-Token: {auth_token}" \
--header 'Content-Type: application/json' \
--data-raw '{"query":"mutation {\n  undeploySchema(\n    keyspace: \"library\"\n    expectedVersion: \" 6c34d600-a3a7-11eb-a22f-7bb5f4c20029\")\n}","variables":{}}'
