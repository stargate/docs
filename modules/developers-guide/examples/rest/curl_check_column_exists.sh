curl -s -L \
-X GET localhost:8082/v2/schemas/keyspaces/users_keyspace/tables/users/columns \
-H "X-Cassandra-Token: $AUTH_TOKEN" \
-H "Accept: application/json" \
-H "Content-Type: application/json"
