curl -L -X  GET '{base_doc_url}{base_doc_api}/{namespace}/collections/{collection}?where=\{"name":\{"$eq":"Amy Smith"\}\}' \
--header "X-Cassandra-Token: {auth_token}" \
--header 'Content-Type: application/json'
