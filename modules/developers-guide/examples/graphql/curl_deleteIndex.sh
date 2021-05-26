curl --location --request POST {base_url}{base_gql_schema} \
--header "X-Cassandra-Token: {auth_token}" \
--header 'Content-Type: application/json' \
--data-raw '{"query":"mutation dropIndexBdate {\n\n  reader: dropIndex(\n      keyspaceName:\"library\",\n      indexName:\"reader_bdate_idx\"\n  )\n}","variables":{}}'
