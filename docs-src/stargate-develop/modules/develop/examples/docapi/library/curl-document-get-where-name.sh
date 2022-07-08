curl --location -g --request GET '{base_doc_url}{base_doc_api}/{namespace}/collections/{collection}?where={"reader.name":{"$eq":"Amy%20Smith"}}' \
--header "X-Cassandra-Token: {auth_token}" \
--header 'Content-Type: application/json' \
--data-raw ''
