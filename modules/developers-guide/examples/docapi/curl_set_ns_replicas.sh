curl --location --request POST '{my_base_url}{my_base_api_path}/schemas/namespaces' \
--header "X-Cassandra-Token: $AUTH_TOKEN" \
--header 'Content-Type: application/json' \
--data '{
    "name": "myworld",
    "replicas": 2
}'
