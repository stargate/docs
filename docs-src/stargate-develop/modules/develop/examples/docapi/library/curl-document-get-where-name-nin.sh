curl --location -g --request GET '{base_doc_url}{base_doc_api}/{namespace}/collections/{collection}?where={"reader.name":{"$nin":["Jane%20Doe","Amy%20Smith"]}}&fields=["reader.name","reader.birthdate","reader.reviews"]&page-size=6' \
--header "X-Cassandra-Token: {auth_token}" \
--header 'Content-Type: application/json' \
--data-raw ''
