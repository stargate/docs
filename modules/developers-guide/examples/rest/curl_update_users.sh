curl -s -L -X PUT '{my_base_url}{my_base_api_path}/keyspaces/users_keyspace/users/Mookie/Betts' \
-H "X-Cassandra-Token: $AUTH_TOKEN" \
-H 'Content-Type: application/json' \
-d '{
    "email": "mookie.betts.new-email@email.com"
}'
