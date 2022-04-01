curl -s -X POST {base_rest_url}{base_rest_schema}/{rkeyspace}/{rtable} \
-H  "accept: application/json" \
-H  "X-Cassandra-Token: {auth_token}" \
-H  "Content-Type: application/json" \
-d '{"firstname": "{user2fn}",
  "lastname": "{user2ln}",
  "favorite color": "grey",
  "favorite_books": [ "Emma", "The Color Purple" ]
}'
