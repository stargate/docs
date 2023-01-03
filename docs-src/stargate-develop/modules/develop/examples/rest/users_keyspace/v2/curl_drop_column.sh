curl -s --location \
--request DELETE {base_rest_url}{base_rest_schema}/{rkeyspace}/tables/{rtable}/columns/email \
--header "X-Cassandra-Token: {auth_token}" \
--header "Content-Type: application/json"
