curl --location -g --request GET '{base_doc_url_v2}{base_doc_api}/{namespace}/collections/{collection}/{bookdocid}?fields=["book.title","book.genre"]' \
--header "X-Cassandra-Token: {auth_token}" \
--header 'Content-Type: application/json'
