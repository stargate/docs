curl -L -X GET '{my_base_url}{my_base_api_path}/schemas/namespaces' \
-H "X-Cassandra-Token: $AUTH_TOKEN" \
-H 'Content-Type: application/json'
