curl -L \
-X DELETE '{my_base_url}{my_base_api_path}/namespaces/myworld/collections/fitness/{docid}' \
--header "X-Cassandra-Token: $AUTH_TOKEN" \
--header 'Content-Type: application/json'
