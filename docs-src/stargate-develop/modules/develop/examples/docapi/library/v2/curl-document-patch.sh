curl --location --request PATCH '{base_doc_url_v2}{base_doc_api}/{namespace}/collections/{collection}/{docid}' \
--header "X-Cassandra-Token: {auth_token}" \
--header 'Content-Type: application/json' \
--data-raw ' {
  "yet-another-field": "Hopefully, I haven'\''t lost my other two fields!"
}'
