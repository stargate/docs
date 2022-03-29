curl --location \
--request GET '{base_doc_url}{base_doc_api}/{namespace}/collections/books?page-size=5&page-state=JGNlYjczMDc5LTE1NTItNGQyNS1hM2ExLWE2MzgxNWVlYTAyMADwf_____B_____ \' \
--header "X-Cassandra-Token: $AUTH_TOKEN" \
--header 'Content-Type: application/json'
