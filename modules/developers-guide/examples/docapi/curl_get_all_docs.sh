curl --location \
--request GET 'localhost:8082/v2/namespaces/myworld/collections/fitness?page-size=3' \
--header "X-Cassandra-Token: $AUTH_TOKEN" \
--header 'Content-Type: application/json'
