curl --location \
--request GET '{base_doc_url}{base_doc_api}/{namespace}/collections/{collection}?page-size=3' \
--header "X-Cassandra-Token: $AUTH_TOKEN" \
--header 'Content-Type: application/json'
