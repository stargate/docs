curl --location --globoff --request GET '{base_doc_url_v2}{base_doc_api}/{namespace}/collections/{collection}?where={"reader.name":{"$eq":"Jane%20Doe"}}&fields=["reader.name", "reader.address","reader.reviews"]' \
--header "X-Cassandra-Token: {auth_token}" \
--header 'Content-Type: application/json'
