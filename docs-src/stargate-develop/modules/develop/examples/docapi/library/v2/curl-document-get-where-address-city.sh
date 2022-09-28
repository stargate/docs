curl --location -g --request GET '{base_doc_url_v2}{base_doc_api}/{namespace}/collections/{collection}?where={"reader.address.primary,secondary.city":{"$eq":"Evertown"}}&fields=["reader.name","reader.address","reader.reviews"]' \
--header "X-Cassandra-Token: {auth_token}" \
--header 'Content-Type: application/json' \

