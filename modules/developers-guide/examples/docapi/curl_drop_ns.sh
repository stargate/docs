curl -L -X DELETE 'localhost:8082/v2/schemas/namespaces/myworld' \
--header "X-Cassandra-Token: $AUTH_TOKEN" \
--header 'Content-Type: application/json'
