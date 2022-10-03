curl --location --request POST '{base_doc_url}{base_doc_schema}' \
--header "X-Cassandra-Token: {auth_token}" \
--header 'Content-Type: application/json' \
--data '{
    "name": "{namespace}"
}'
