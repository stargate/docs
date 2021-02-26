curl -s -L \
-X PUT {my_base_url}{my_base_api_schema_path}/keyspaces/users_keyspace/tables/users/columns/firstname \
-H "X-Cassandra-Token: $AUTH_TOKEN" \
-H  "Accept: application/json" \
-H "Content-Type: application/json" \
-d '{   "name": "first",   "typeDefinition": "varchar"}'
