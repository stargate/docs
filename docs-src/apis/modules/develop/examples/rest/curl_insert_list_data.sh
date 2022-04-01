curl -s -X POST {base_rest_url}{base_rest_schema}/{rkeyspace}/{rtable} \
-H  "X-Cassandra-Token: {auth_token}" \
-H  "Content-Type: application/json" \
-H  "Accept: application/json" \
-d '{"firstname": "Janesha",
  "lastname": "Doesha",
  "favorite color": "grey",
  "top_three_tv_shows": [ "The Magicians", "The Librarians", "Agents of SHIELD" ]
}'
