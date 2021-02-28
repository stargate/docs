curl --location --request POST --url {my_base_url}{my_base_api_schema_path} \
--header "X-Cassandra-Token: $AUTH_TOKEN" \
--header "Content-Type: application/json" \
--data-raw '{"query":"mutation createKsLibrary {\n  createKeyspace(name:\"library\", replicas: 1)\n}","variables":{}}'
