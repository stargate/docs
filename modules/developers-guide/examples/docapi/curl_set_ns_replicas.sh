curl --location --request POST 'localhost:8082/v2/schemas/namespaces' \
--header "X-Cassandra-Token: $AUTH_TOKEN" \
--header 'Content-Type: application/json' \
--data '{
    "name": "myworld",
    "replicas": 2
}'
