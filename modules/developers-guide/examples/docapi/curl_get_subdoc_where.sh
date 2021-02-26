curl -L -X  GET '{my_base_url}{my_base_api_path}/namespaces/myworld/collections/fitness?where=\{"weights.type":\{"$eq":"bench%20press"\}\}' \
--header "X-Cassandra-Token: $AUTH_TOKEN" \
--header 'Content-Type: application/json'
