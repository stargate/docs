curl -L -X GET 'localhost:8082/v2/namespaces/myworld/collections/fitness/Janet' \
 --header "X-Cassandra-Token: $AUTH_TOKEN" \
 --header 'Content-Type: application/json'
