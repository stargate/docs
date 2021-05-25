curl --location --request POST '{base_url}{base_gql_schema}' \
--header "X-Cassandra-Token: {auth_token}" \
--header 'Content-Type: application/json' \
--data-raw '{"query":"# create a keyspace called library\nmutation createKsLibrary {\n  createKeyspace(name:\"library\", replicas: 1)\n}","variables":{}}'
