curl --location \
--request GET '{my_base_url}{my_base_api_path}/namespaces/myworld/collections/fitness?page-size=3' \
--header "X-Cassandra-Token: $AUTH_TOKEN" \
--header 'Content-Type: application/json'
