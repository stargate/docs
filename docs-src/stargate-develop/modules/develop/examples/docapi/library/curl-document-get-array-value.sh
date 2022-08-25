curl -L -X  GET '{base_doc_url}{base_doc_api}/{namespace}/collections/{collection}/book/Moby%20Dick.author[0]' \
--header "X-Cassandra-Token: {auth_token}" \
--header "Content-Type: application/json"
