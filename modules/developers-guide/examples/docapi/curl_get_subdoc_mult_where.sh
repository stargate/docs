curl -L -X  GET '{my_base_url}{my_base_api_path}/namespaces/myworld/collections/fitness?where=\{"weights.reps":\{"$gt":12\},"weights.reps":\{"$lt":20\}\}' \
--header "X-Cassandra-Token: $AUTH_TOKEN" \
--header 'Content-Type: application/json'
