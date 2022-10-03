curl --location -g --request GET '{base_doc_url_v2}{base_doc_api}/{namespace}/collections/{collection}?where={"reader.name":{"$eq":"Amy%20Smith"}}&fields=["reader.name","reader.birthdate"]' \
--header "X-Cassandra-Token: {auth_token}" \
--header 'Content-Type: application/json' \

