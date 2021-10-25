curl -s -L -X GET localhost:8082/v2/keyspaces/users_keyspace/users/rows \
-H "X-Cassandra-Token: $AUTH_TOKEN" \
-H "Content-Type: application/json" \
-H "Accept: application/json"
