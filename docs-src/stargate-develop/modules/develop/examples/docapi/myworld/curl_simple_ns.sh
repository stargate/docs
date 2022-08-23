curl --location --request POST '{base_doc_url}{base_doc_api}' \
--header "X-Cassandra-Token: {auth_token}" \
--header 'Content-Type: application/json' \
--data '{
    "name": "{namespace}"
}'
