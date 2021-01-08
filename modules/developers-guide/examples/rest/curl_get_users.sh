curl -L -X GET 'http://localhost:8082/v2/keyspaces/users_keyspace/users?where=\{"firstname":\{"$in":\["Janesha","Mookie"\]\}\}' \
-H "X-Cassandra-Token: $AUTH_TOKEN" \
-H 'Content-Type: application/json'
