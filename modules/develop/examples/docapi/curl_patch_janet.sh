curl -L \
-X PATCH 'l{base_doc_url}{base_doc_api}/{namespace}/collections/{collection}/Janet' \
--header "X-Cassandra-Token: $AUTH_TOKEN" \
--header 'Content-Type: application/json' \
--data '{
    "firstname": "JanetLee",
    "lastname": "Doe"
}'
