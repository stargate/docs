curl -L -X  GET '{my_base_url}{my_base_api_path}/{my_namespace}/collections/{my_collection}?where=\{"weights.reps":\{"$gt":12\},"weights.reps":\{"$lt":20\}\}' \
--header "X-Cassandra-Token: $AUTH_TOKEN" \
--header 'Content-Type: application/json'
