curl --location --request POST '{base_doc_url_v2}{base_doc_schema}' \
--header "X-Cassandra-Token: {auth_token}" \
--header 'Content-Type: application/json' \
--data '{
    "name": "{namespace}",
    "replicas": 2
}'
