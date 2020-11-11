curl -L -X PUT 'localhost:8082/v2/keyspaces/users_keyspace/users/Mookie/Betts' \
-H "X-Cassandra-Token: $AUTH_TOKEN" \
-H 'Content-Type: application/json' \
-d '{
    "email": "mookie.betts.new-email@email.com"
}'
