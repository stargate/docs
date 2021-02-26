curl --location --request GET '{my_base_url}{my_base_api_path}/namespaces/myworld/collections/fitness/Joey/weights' \
--header "X-Cassandra-Token: $AUTH_TOKEN" \
--header 'Content-Type: application/json'
