curl -L \
-X DELETE --url {my_base_url}{my_base_api_path}/{namespace}/collections/{collectionName} \
--header "X-Cassandra-Token: $AUTH_TOKEN" \
--header 'Content-Type: application/json'
