<<<<<<< HEAD:docs-src/stargate-develop/modules/develop/examples/rest/curl_insert_tuple_data.sh
curl -s -X POST {base_rest_url}{base_rest_api}/{rkeyspace}/{rtable} \
=======
curl -s -X POST https://localhost:8082/v2/keyspaces/users_keyspace/users \
>>>>>>> main:modules/developers-guide/examples/rest/curl_insert_tuple_data.sh
-H  "accept: application/json" \
-H  "X-Cassandra-Token: $AUTH_TOKEN" \
-H  "Content-Type: application/json" \
-d '{"firstname": "Janesha",
  "lastname": "Doesha",
  "favorite color": "grey",
  "current_country": [ "France", "2016-01-01", "2020-02-02" ]
}'
