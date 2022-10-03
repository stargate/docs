curl --location --request PUT '{base_doc_url_v2}{base_doc_api}/{namespace}/collections/{collection}/{docid}' \
--header "X-Cassandra-Token: {auth_token}" \
--header 'Content-Type: application/json' \
--data-raw ' {
  "id": "some-other-stuff",
  "other": "This is changed nonsensical stuff."
}'
