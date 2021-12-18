curl -L -X POST '{base_url}{base_doc_schema}' \
-H "X-Cassandra-Token: $AUTH_TOKEN" \
-H 'Content-Type: application/json' \
-d '{
    "name": "{namespace}",
    "replicas": 1
}'
