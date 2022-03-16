curl -s -L -X POST localhost:8082/v2/schemas/keyspaces \
-H "X-Cassandra-Token: $AUTH_TOKEN" \
-H "Content-Type: application/json" \
-d '{
    "name": "users_keyspace",
    "replicas": 1
}'
