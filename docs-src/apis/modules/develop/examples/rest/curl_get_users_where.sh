curl -s -L -X GET '{base_rest_url}{base_rest_schema}/{rkeyspace}/{rtable}?where=\{"firstname":\{"$eq":"Mookie"\}\}' \
--header "X-Cassandra-Token: $AUTH_TOKEN" \
--header "Content-Type: application/json"
