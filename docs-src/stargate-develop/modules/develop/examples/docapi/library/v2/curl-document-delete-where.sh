curl --location -g --request DELETE '{base_doc_url_v2}{base_doc_api}/{namespace}/collections/{collection}/{docid}?where={ "id":{"$eq":"some stuff"}}' \
--header "X-Cassandra-Token: {auth_token}" \
--header 'Content-Type: application/json' \

