curl --location \
--request DELETE 'localhost:8082/v2/schemas/keyspaces/users_keyspace/tables/users' \
--header "X-Cassandra-Token: $AUTH_TOKEN" \
--header "Content-Type: application/json"
