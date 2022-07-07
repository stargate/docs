curl -L -X GET '{base_doc_url}{base_doc_api}/{namespace}/collections/{collection}/json-schema' \
-H "X-Cassandra-Token: {auth_token}" \
-H 'Content-Type: application/json'
