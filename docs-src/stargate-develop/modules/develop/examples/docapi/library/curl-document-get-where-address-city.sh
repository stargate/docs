curl --location -g --request GET '{base_doc_url}{base_doc_api}/{namespace}/collections/{collection}?fields=["reader.name", "reader.address","reader.reviews"]&where={"reader.address.primary,secondary.city":{"$eq":"Evertown"}}' \
--header "X-Cassandra-Token: {auth_token}" \
--header 'Content-Type: application/json' \
--data-raw ''
