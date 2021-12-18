curl -L -X DELETE '{base_url}{base_doc_schema}/{namespace}' \
--header "X-Cassandra-Token: $AUTH_TOKEN" \
--header 'Content-Type: application/json'
