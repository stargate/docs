curl --location \
--request POST 'localhost:8082/v2/schemas/keyspaces/users_keyspace/tables/users/columns/email' \
--header 'X-Cassandra-Token: $AUTH_TOKEN' \
--header 'Content-Type: application/json'
