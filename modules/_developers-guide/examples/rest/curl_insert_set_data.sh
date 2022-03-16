curl -s -X POST http://localhost:8082/v2/keyspaces/users_keyspace/users \
-H  "accept: application/json" \
-H  "X-Cassandra-Token: $AUTH_TOKEN" \
-H  "Content-Type: application/json" \
-d '{"firstname": "Janesha",
  "lastname": "Doesha",
  "favorite color": "grey",
  "favorite_books": [ "Emma", "The Color Purple" ]
}'
