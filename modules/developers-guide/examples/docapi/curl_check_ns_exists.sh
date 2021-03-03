curl -L -X GET --url {my_base_url}{my_base_api_schema_path}/namespaces \
-H "X-Cassandra-Token: $AUTH_TOKEN" \
-H 'Content-Type: application/json'
