curl -s -L \
-X GET localhost:8082/v2/schemas/keyspaces/users_keyspace/tables/users \
-H "X-Cassandra-Token: $AUTH_TOKEN" \
-H "Content-Type: application/json" \
-H "Accept: application/json"
