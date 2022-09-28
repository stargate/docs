curl --location \
--request PUT '{base_doc_url_v2}{base_doc_api}/{namespace}/collections/{collection}/{docid}' \
--header "X-Cassandra-Token: {auth_token}" \
--header 'Content-Type: application/json' \
--data '{
  "stuff": "2545331a-aaad-45d2-b084-9da3d8f4c311",
  "other": "I need a document with a set value for a test."
}'
