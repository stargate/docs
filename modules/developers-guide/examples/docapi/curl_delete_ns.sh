curl -L -X DELETE --url {my_base_url}{my_base_api_schema_path}/namespaces/{my_namespace} \
--header "X-Cassandra-Token: $AUTH_TOKEN" \
--header 'Content-Type: application/json'
