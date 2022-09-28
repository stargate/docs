curl -X GET '{base_doc_url_v2}{base_doc_schema}/{namespace}/functions' \
--header "X-Cassandra-Token: {auth_token}" \
--header 'Content-Type: application/json'
