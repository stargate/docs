curl --location -g --request GET '{base_doc_url_v2}{base_doc_api}/{namespace}/collections/{collection}?where={"$or":[{"reader.name":{"$eq":"Amy%20Smith"}},{"reader.name":{"$eq":"Jane%20Doe"}}]}&fields=["reader.name","reader.user_id","reader.birthdate"]&page-size=6' \
--header "X-Cassandra-Token: {auth_token}" \
--header 'Content-Type: application/json' \
