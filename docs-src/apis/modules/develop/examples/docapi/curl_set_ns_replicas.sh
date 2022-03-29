curl --location --request POST '{base_doc_url}{base_doc_schemas}' \
--header "X-Cassandra-Token: $AUTH_TOKEN" \
--header 'Content-Type: application/json' \
--data '{
    "name": "{namespace}",
    "replicas": 2
}'
