curl -s -L -X POST {base_rest_url}{base_rest_schema}/{rkeyspace}/tables/{rtable}/columns \
-H "X-Cassandra-Token: {auth_token}" \
-H  "Accept: application/json" \
-H "Content-Type: application/json" \
-d '{
   "name": "address",
   "typeDefinition": "address_type"
}'
