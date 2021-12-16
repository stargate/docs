curl -s -L \
-X GET {base_url}{base_rest_schema}/{rkeyspace}/tables/{rtable}/columns \
-H "X-Cassandra-Token: $AUTH_TOKEN" \
-H "Accept: application/json" \
-H "Content-Type: application/json"
