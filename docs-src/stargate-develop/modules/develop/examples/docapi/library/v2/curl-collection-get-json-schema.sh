curl -L -X GET '{base_doc_url_v2}{base_doc_api}/{namespace}/collections/{collection2}/json-schema' \
-H "X-Cassandra-Token: {auth_token}" \
-H 'Content-Type: application/json'
