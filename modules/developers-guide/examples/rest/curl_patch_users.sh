curl -s -L -X PATCH '{my_base_url}{my_base_api_path}/{my_keyspace}/{my_table}/Mookie/Betts' \
-H "X-Cassandra-Token: $AUTH_TOKEN" \
-H 'Content-Type: application/json' \
-d '{
    "email": "mookie.betts.email@email.com"
}'
