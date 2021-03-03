curl --location \
--request GET --url {my_base_url}{my_base_api_path}/{my_namespace}/collections/{my_collection}?page-size=3 \
--header "X-Cassandra-Token: $AUTH_TOKEN" \
--header 'Content-Type: application/json'
