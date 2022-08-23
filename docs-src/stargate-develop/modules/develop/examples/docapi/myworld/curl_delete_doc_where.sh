curl -L -X  DELETE '{base_doc_url}{base_doc_api}/{namespace}/collections/{collection}?where=\{"id":\{"$eq":"some%2Dstuff"\}\}' \
--header "X-Cassandra-Token: {auth_token}" \
--header 'Content-Type: application/json'
