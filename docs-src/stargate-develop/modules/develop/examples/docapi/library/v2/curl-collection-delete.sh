curl -L \
-X DELETE '{base_doc_url_v2}{base_doc_api}/{namespace}/collections/{collection}' \
--header "X-Cassandra-Token: {auth_token}" \
--header 'Content-Type: application/json'
