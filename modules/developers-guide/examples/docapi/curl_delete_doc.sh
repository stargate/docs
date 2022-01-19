curl -L \
-X DELETE 'https://localhost:8082/v2/namespaces/myworld/collections/fitness/{docid}' \
--header "X-Cassandra-Token: $AUTH_TOKEN" \
--header 'Content-Type: application/json'
