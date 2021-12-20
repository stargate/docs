curl -X GET '{base_doc_url}{base_doc_schema}/namespaces/{namespace}' \
--header "X-Cassandra-Token: $AUTH_TOKEN" \
--header 'Content-Type: application/json'
