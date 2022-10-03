curl -X GET '{base_doc_url}{base_doc_schema}/{namespace}/functions' \
--header "X-Cassandra-Token: {auth_token}" \
--header 'Content-Type: application/json'
