curl -s --location \
--request DELETE {base_url}{base_rest_schema}/{rkeyspace}/tables/{rtable} \
--header "X-Cassandra-Token: $AUTH_TOKEN" \
--header "Content-Type: application/json"
