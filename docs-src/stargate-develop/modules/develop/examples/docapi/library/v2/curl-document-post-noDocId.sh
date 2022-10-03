curl --location \
--request POST '{base_doc_url_v2}{base_doc_api}/{namespace}/collections/{collection}' \
--header "X-Cassandra-Token: {auth_token}" \
--header 'Content-Type: application/json' \
--data '{
  "id": "some-stuff",
  "other": "This is nonsensical stuff."
}'
