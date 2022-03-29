curl -s -L \
-X PUT {base_rest_url}{base_rest_schema}/{rkeyspace}/tables/{rtable}/columns/firstname \
-H "X-Cassandra-Token: $AUTH_TOKEN" \
-H  "Accept: application/json" \
-H "Content-Type: application/json" \
-d '{   "name": "first",   "typeDefinition": "varchar"}'
