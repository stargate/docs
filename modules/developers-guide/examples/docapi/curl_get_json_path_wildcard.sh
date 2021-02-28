curl -L -X  GET '{my_base_url}{my_base_api_path}/{my_namespace}/collections/{my_collection}?where=\{"weights.*":\{"$gt":11\},"weights.*":\{"$lt":16\}\}&page-size=3' \
--header "X-Cassandra-Token: $AUTH_TOKEN" \
--header "Content-Type: application/json"
