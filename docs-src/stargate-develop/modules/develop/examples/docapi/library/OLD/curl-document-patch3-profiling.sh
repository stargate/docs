curl --location --request PATCH '{base_doc_url}{base_doc_api}/{namespace}/collections/{collection}/{docid}?profile=true' \
--header "X-Cassandra-Token: {auth_token}" \
--header 'Content-Type: application/json' \
--data-raw ' {
  "yet-another-field": "Hopefully, I haven'\''t lost my other two fields!",
  "choices": [
     "eeny",
     "meeny",
     "meiny",
     "mo"
  ]
}'
