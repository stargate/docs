<<<<<<< HEAD:docs-src/stargate-develop/modules/develop/examples/rest/curl_insert_map_data.sh
curl -s -L -X POST {base_rest_url}{base_rest_api}/{rkeyspace}/{rtable} \
-H  "X-Cassandra-Token: {auth_token}" \
=======
curl -s -L -X POST https://localhost:8082/v2/keyspaces/users_keyspace/users \
-H  "X-Cassandra-Token: $AUTH_TOKEN" \
>>>>>>> main:modules/developers-guide/examples/rest/curl_insert_map_data.sh
-H  "Content-Type: application/json" \
-H  "Accept: application/json" \
-d '{"firstname": "{user2fn}",
  "lastname": "{user2ln}",
  "favorite color": "grey",
  "top_three_tv_shows": [ "The Magicians", "The Librarians", "Agents of SHIELD" ],
  "evaluations": [ {"key":"2020", "value":"good"}, {"key":"2019", "value":"okay"} ]
}'
