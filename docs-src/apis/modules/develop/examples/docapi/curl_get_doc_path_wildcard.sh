curl -L -X  GET '{base_doc_url}{base_doc_api}/{namespace}/collections/{collection}?where=\{"weights.*":\{"$gt":11\},"weights.*":\{"$lt":16\}\}&page-size=3' \
--header "X-Cassandra-Token: {auth_token}" \
--header "Content-Type: application/json"
