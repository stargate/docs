curl -L -X  GET 'localhost:8082/v2/namespaces/myworld/collections/fitness?where=\{"weights.*":\{"$gt":11\},"weights.*":\{"$lt":16\}\}&page-size=3' \
--header "X-Cassandra-Token: $AUTH_TOKEN" \
--header "Content-Type: application/json"
