curl --location \
--request GET '{base_doc_url}{base_doc_api}/{namespace}/collections/books?page-size=5' \
--header "X-Cassandra-Token: $AUTH_TOKEN" \
--header 'Content-Type: application/json'
