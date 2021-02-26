curl -s -L -X POST {my_base_url}{my_base_api_schema_path}/keyspaces \
-H "X-Cassandra-Token: $AUTH_TOKEN" \
-H "Content-Type: application/json" \
-d '{
    "name": "users_keyspace",
    "replicas": 1
}'
