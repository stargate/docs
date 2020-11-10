curl -L -X GET 'localhost:8082/v2/schemas/keyspaces' \
--header "X-Cassandra-Token: $AUTH_TOKEN" \
--header 'Content-Type: application/json'
