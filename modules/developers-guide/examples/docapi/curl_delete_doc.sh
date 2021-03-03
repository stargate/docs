curl -L \
-X DELETE --url {my_base_url}{my_base_api_path}/{my_namespace}/collections/{my_collection}/{docid} \
--header "X-Cassandra-Token: $AUTH_TOKEN" \
--header 'Content-Type: application/json'
