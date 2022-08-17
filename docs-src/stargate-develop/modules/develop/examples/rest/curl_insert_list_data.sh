<<<<<<< HEAD:docs-src/stargate-develop/modules/develop/examples/rest/curl_insert_list_data.sh
curl -s -X POST {base_rest_url}{base_rest_api}/{rkeyspace}/{rtable} \
-H  "X-Cassandra-Token: {auth_token}" \
=======
curl -s -X POST https://localhost:8082/v2/keyspaces/users_keyspace/users \
-H  "X-Cassandra-Token: $AUTH_TOKEN" \
>>>>>>> main:modules/developers-guide/examples/rest/curl_insert_list_data.sh
-H  "Content-Type: application/json" \
-H  "Accept: application/json" \
-d '{"firstname": "Janesha",
  "lastname": "Doesha",
  "favorite color": "grey",
  "top_three_tv_shows": [ "The Magicians", "The Librarians", "Agents of SHIELD" ]
}'
