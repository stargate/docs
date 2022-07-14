curl --location --request PUT 'localhost:8082/v2/namespaces/test/collections/library/native-son-doc-id/book' \
curl -X 'PUT' \
  'http://{base_doc_url}{base_doc_api}/{namespace}/collections/{collection}/{bookdocid}/book' \
  -H 'accept: application/json' \
  -H 'X-Cassandra-Token: 018d894e-dd86-486f-ba9a-df9d132096bf' \
  -H 'Content-Type: application/json' \
  -d '{ "title": "Native Daughter" }'
