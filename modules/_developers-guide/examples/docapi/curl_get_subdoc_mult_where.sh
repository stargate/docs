curl -L -X  GET 'localhost:8082/v2/namespaces/myworld/collections/fitness?where=\{"weights.reps":\{"$gt":12\},"weights.reps":\{"$lt":20\}\}' \
--header "X-Cassandra-Token: $AUTH_TOKEN" \
--header 'Content-Type: application/json'
