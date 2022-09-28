curl --location -g --request GET '{base_doc_url_v2}{base_doc_api}/{namespace}/collections/{collection}/{readerdocid}/reader/reviews?WHERE={"reader.reviews.rating":{"$eq":5}' \
--header "X-Cassandra-Token: {auth_token}" \
--header 'Content-Type: application/json' \

