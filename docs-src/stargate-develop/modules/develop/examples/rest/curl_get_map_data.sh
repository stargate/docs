<<<<<<< HEAD:docs-src/stargate-develop/modules/develop/examples/rest/curl_get_map_data.sh
curl -s -L -G {base_rest_url}{base_rest_schema}/{rkeyspace}/{rtable} \
   -H  "X-Cassandra-Token: {auth_token}" \
=======
curl -s -L -G https://localhost:8082/v2/keyspaces/users_keyspace/users \
   -H  "X-Cassandra-Token: $AUTH_TOKEN" \
>>>>>>> main:modules/developers-guide/examples/rest/curl_get_map_data.sh
   -H  "Content-Type: application/json" \
    -H "Accept: application/json" \
   --data-urlencode 'where={
     "firstname": {"$eq": "Janesha"},
     "lastname": {"$eq": "Doesha"},
     "evaluations": {"$containsKey": "2020"}
   }'
