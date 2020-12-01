curl -L -X GET 'localhost:8082/v2/schemas/keyspaces/users_keyspace/tables' \
-H "X-Cassandra-Token: $AUTH_TOKEN" \
-H "accept: application/json" 
