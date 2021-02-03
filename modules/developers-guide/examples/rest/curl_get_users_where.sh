curl -s -L -X GET 'http://localhost:8082/v2/keyspaces/users_keyspace/users?where=\{"firstname":\{"$eq":"Mookie"\}\}' \
--header "X-Cassandra-Token: $AUTH_TOKEN" \
--header "Content-Type: application/json"
