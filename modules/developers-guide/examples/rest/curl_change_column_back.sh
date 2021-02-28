curl -s -L \
-X PUT {my_base_url}{my_base_api_schema_path}/{my_keyspace}/tables/{my_table}/columns/first \
-H "X-Cassandra-Token: $AUTH_TOKEN" \
-H  "Accept: application/json" \
-H "Content-Type: application/json" \
-d '{   "name": "firstname",   "typeDefinition": "varchar"}'
