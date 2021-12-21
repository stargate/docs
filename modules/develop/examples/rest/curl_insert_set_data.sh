curl -s -X POST {base_rest_url}{base_rest_schema}/{rkeyspace}/{rtable} \
-H  "accept: application/json" \
-H  "X-Cassandra-Token: $AUTH_TOKEN" \
-H  "Content-Type: application/json" \
-d '{"firstname": "Janesha",
  "lastname": "Doesha",
  "favorite color": "grey",
  "favorite_books": [ "Emma", "The Color Purple" ]
}'
