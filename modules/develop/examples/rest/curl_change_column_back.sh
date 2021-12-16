curl -s -L \
-X PUT http://localhost:8082/v2/schemas/keyspaces/users_keyspace/tables/users/columns/first \
-H "X-Cassandra-Token: $AUTH_TOKEN" \
-H  "Accept: application/json" \
-H "Content-Type: application/json" \
-d '{   "name": "firstname",   "typeDefinition": "varchar"}'
