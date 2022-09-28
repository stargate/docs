curl --location -g --request DELETE '{base_doc_url_v2}{base_doc_api}/{namespace}/collections/{collection}/{readerdocid}/reader/address/secondary' \
--header "X-Cassandra-Token: {auth_token}" \
--header 'Content-Type: application/json' \

