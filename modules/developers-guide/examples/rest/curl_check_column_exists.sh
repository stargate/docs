curl -L \
-X GET 'localhost:8082/v2/schemas/keyspaces/'users_keyspace'/tables/users/columns' \
-H "accept: application/json" \
-H "content-type: application/json" \
-H "X-Cassandra-Token: $AUTH_TOKEN"
