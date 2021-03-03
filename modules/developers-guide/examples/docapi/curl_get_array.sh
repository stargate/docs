curl -L -X  GET --url {my_base_url}{my_base_api_path}/{my_namespace}/collections/{my_collection}/Joey.weights[0] \
--header "X-Cassandra-Token: $AUTH_TOKEN" \
--header "Content-Type: application/json"
