curl -L \
-X GET '{base_doc_url}{base_doc_api}/{namespace}/collections/{collection}/{docid}' \
--header "X-Cassandra-Token: {auth_token}" \
--header 'Content-Type: application/json'
