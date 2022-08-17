curl -s -L \
<<<<<<< HEAD:docs-src/stargate-develop/modules/develop/examples/rest/curl_change_column.sh
-X PUT {base_rest_url}{base_rest_schema}/{rkeyspace}/tables/{rtable}/columns/firstname \
-H "X-Cassandra-Token: {auth_token}" \
=======
-X PUT https://localhost:8082/v2/schemas/keyspaces/users_keyspace/tables/users/columns/firstname \
-H "X-Cassandra-Token: $AUTH_TOKEN" \
>>>>>>> main:modules/developers-guide/examples/rest/curl_change_column.sh
-H  "Accept: application/json" \
-H "Content-Type: application/json" \
-d '{   "name": "first",   "typeDefinition": "varchar"}'
