curl -s -L -X GET {base_rest_url}{base_rest_schema}/{rkeyspace}/tables \
-H "X-Cassandra-Token: $AUTH_TOKEN" \
-H "Content-Type: application/json" \
-H "Accept: application/json" 
