curl -s -L -X GET {base_rest_url}{base_rest_schema}/{rkeyspace} \
-H "X-Cassandra-Token: {auth_token}" \
-H "Content-Type: application/json" \
-H "Accept: application/json"
