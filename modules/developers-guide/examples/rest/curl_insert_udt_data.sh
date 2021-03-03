curl -s -X POST {my_base_url}{my_base_api_path}/{my_keyspace}/{my_table} \
-H  "accept: application/json" \
-H  "X-Cassandra-Token: $AUTH_TOKEN" \
-H  "Content-Type: application/json" \
-d '{"firstname": "Janesha",
  "lastname": "Doesha",
  "favorite color": "grey",
  "address": { "street": "1, Main St", "city": "San Francisco", "state": "California", "zip": "12345" }
}'
