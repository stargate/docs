curl -s --location \
--request DELETE {base_rest_url}{base_rest_schema}{rkeyspace} \
--header "X-Cassandra-Token: $AUTH_TOKEN" \
--header "Content-Type: application/json"
