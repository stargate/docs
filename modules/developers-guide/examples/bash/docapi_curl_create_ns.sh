curl -L -X POST 'localhost:8082/v2/schemas/namespaces' \
-H 'X-Cassandra-Token: $AUTH_TOKEN' \
-H 'Content-Type: application/json' \
-d '{
    "name": "myworld",
    "replicas": 1
}'
