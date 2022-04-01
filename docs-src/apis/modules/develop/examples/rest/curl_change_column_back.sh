curl -s -L \
-X PUT {base_rest_url}{base_rest_schema}/{rkeyspace}/tables/{rtable}/columns/first \
-H "X-Cassandra-Token: {auth_token}" \
-H  "Accept: application/json" \
-H "Content-Type: application/json" \
-d '{   "name": "firstname",   "typeDefinition": "varchar"}'
