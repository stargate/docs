curl -L -X  GET 'l{base_doc_url}{base_doc_api}/{namespace}/collections/{collection}?where=\{"weights.type":\{"$eq":"bench%20press"\}\}' \
--header "X-Cassandra-Token: {auth_token}" \
--header 'Content-Type: application/json'
