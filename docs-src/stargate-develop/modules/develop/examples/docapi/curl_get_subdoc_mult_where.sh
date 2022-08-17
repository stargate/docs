curl -L -X  GET '{base_doc_url}{base_doc_api}/{namespace}/collections/{collection}?where=\{"weights.reps":\{"$gt":12\},"weights.reps":\{"$lt":20\}\}' \
--header "X-Cassandra-Token: {auth_token}" \
--header 'Content-Type: application/json'
