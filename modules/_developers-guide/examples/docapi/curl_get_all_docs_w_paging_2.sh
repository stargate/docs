curl --location \
--request GET 'localhost:8082/v2/namespaces/myworld/collections/books?page-size=5&page-state=JGNlYjczMDc5LTE1NTItNGQyNS1hM2ExLWE2MzgxNWVlYTAyMADwf_____B_____ \' \
--header "X-Cassandra-Token: $AUTH_TOKEN" \
--header 'Content-Type: application/json'
