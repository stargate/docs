curl --location --request GET '{base_doc_url}{base_doc_api}/{namespace}/collections/{collection}/{bookdocid}/book/genre' \
--header "X-Cassandra-Token: {auth_token}" \
--header 'Content-Type: application/json' \
--data-raw ''
