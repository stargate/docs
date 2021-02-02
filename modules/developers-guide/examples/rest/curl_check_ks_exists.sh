curl -s -L -X GET 'localhost:8082/v2/schemas/keyspaces' \
-H "X-Cassandra-Token: $AUTH_TOKEN" \
-H 'Content-Type: application/json'
