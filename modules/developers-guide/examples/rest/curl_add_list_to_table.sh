curl -L -X POST 'localhost:8082/v2/schemas/keyspaces/users_keyspace/tables/users/columns' \
-H "X-Cassandra-Token: $AUTH_TOKEN" \
-H  'accept: application/json' \
-H 'Content-Type: application/json' \
-d '{
   "name": "top_three_tv_shows",
   "typeDefinition": "list<text>"
}'
