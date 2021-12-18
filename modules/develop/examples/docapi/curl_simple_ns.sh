curl --location --request POST '{base_url}{base_doc_api}' \
--header "X-Cassandra-Token: $AUTH_TOKEN" \
--header 'Content-Type: application/json' \
--data '{
    "name": "{namespace}"
}'
