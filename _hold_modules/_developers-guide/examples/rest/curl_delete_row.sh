curl -s -L -X DELETE localhost:8082/v2/keyspaces/users_keyspace/users/Mookie/Betts \
-H "X-Cassandra-Token: $AUTH_TOKEN" \
-H "Content-Type: application/json"
