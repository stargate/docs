curl -L -X DELETE '{my_base_url}{my_base_api_path}/schemas/namespaces/myworld' \
--header "X-Cassandra-Token: $AUTH_TOKEN" \
--header 'Content-Type: application/json'
