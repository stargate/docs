curl --location -g --request GET '{base_doc_url}{base_doc_api}/{namespace}/collections/{collection}/{readerdocid}/reader/reviews/[1]' \
--header "X-Cassandra-Token: {auth_token}" \
--header 'Content-Type: application/json' \

