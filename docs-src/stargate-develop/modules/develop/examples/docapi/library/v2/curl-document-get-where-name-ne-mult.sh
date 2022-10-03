curl --location -g --request GET '{base_doc_url_v2}{base_doc_api}/{namespace}/collections/{collection}?where={"reader.name":{"$ne":"Amy%20Smith","$exists":true}}&fields=["reader.name","reader.user_id","reader.birthdate"]&page-size=6' \
--header "X-Cassandra-Token: {auth_token}" \
--header 'Content-Type: application/json' \
