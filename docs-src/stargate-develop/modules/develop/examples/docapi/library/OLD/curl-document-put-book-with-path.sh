curl -X 'PUT' \
  'http://{base_doc_url}{base_doc_api}/{namespace}/collections/{collection}/{bookdocid}/book' \
  -H "X-Cassandra-Token: {auth_token}" \
  -H 'accept: application/json' \
  -H 'Content-Type: application/json' \
  -d '{ "title": "Native Daughter" }'
