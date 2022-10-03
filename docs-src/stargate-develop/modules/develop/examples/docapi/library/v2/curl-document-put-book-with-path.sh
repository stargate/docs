curl -X 'PUT' \
  '{base_doc_url_v2}{base_doc_api}/{namespace}/collections/{collection}/{bookdocid}/book' \
  -H "X-Cassandra-Token: {auth_token}" \
  -H 'accept: application/json' \
  -H 'Content-Type: application/json' \
  -d '{ "title": "Native Daughter" }'
