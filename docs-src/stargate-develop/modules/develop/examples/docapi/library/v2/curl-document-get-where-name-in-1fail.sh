curl --location -g --request GET '{base_doc_url_v2}{base_doc_api}/{namespace}/collections/{collection}?where={"reader.name":{"$in":["Jane%20Doe","John%20Smith"]}}&fields=["reader.name","reader.address","reader.reviews"]&page-size=6' \
--header "X-Cassandra-Token: {auth_token}" \
--header 'Content-Type: application/json' \

