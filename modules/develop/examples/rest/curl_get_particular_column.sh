curl -s -L \
-X GET {base_url}{base_rest_schema}/{rkeyspace}/tables/{rtable}/columns/email \
-H "X-Cassandra-Token: $AUTH_TOKEN" \
-H "Content-Type: application/json" \
-H "Accept: application/json"
