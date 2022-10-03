curl --location --request POST '{base_doc_url_v2}{base_doc_api}/{namespace}/collections/{collection}/{bookdocid}/book/genre/function' \
--header "X-Cassandra-Token: {auth_token}" \
--header 'Content-Type: application/json' \
--data-raw ' {
 "operation": "$push", "value": "culture" 
}'
