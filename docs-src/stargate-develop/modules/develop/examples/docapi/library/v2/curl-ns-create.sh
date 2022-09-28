curl -L -X POST '{base_doc_url_v2}{base_doc_schema}' \
-H "X-Cassandra-Token: {auth_token}" \
-H 'Content-Type: application/json' \
-d '{
    "name": "{namespace}",
    "replicas": 1
}'
