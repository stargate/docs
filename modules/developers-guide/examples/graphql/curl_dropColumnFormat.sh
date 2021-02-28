curl --location --request POST --url {my_base_url}{my_base_api_path}{keyspaceName} \
--header "X-Cassandra-Token: $AUTH_TOKEN" \
--header 'Content-Type: application/json' \
--data-raw '{"query":"mutation dropColumnFormat {\n    alterTableDrop(\n    keyspaceName:\"library\",\n    tableName:\"book\",\n    toDrop:[\"format\"]\n  )\n}","variables":{}}'
