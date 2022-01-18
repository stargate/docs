curl -s -X POST https://localhost:8082/v2/keyspaces/users_keyspace/users \
-H  "accept: application/json" \
-H  "X-Cassandra-Token: $AUTH_TOKEN" \
-H  "Content-Type: application/json" \
-d '{"firstname": "Janesha",
  "lastname": "Doesha",
  "favorite color": "grey",
  "address": { "street": "1 Main St", "zip": "12345" }
}'
