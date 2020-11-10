curl -L -X POST 'localhost:8082/v2/schemas/namespaces' \
-H "X-Cassandra-Token: $AUTH_TOKEN" \
-H 'Content-Type: application/json' \
-d '{
    "name": "myworld-dcs",
    "datacenters": [ {"name": "dc1"}, {"name": "dc2", "replicas": 5} ]
}'
