curl -L -X GET '{base_doc_url}/{base_doc_schema}' \
-H "X-Cassandra-Token: $AUTH_TOKEN" \
-H 'Content-Type: application/json'
