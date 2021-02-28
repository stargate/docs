curl -s -L -X DELETE {my_base_url}{my_base_api_path}/{my_keyspace}/{my_table}/Mookie/Betts \
-H "X-Cassandra-Token: $AUTH_TOKEN" \
-H "Content-Type: application/json"
