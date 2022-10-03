curl --location --request PUT '{base_doc_url_v2}{base_doc_api}/{namespace}/collections/{collection}/{docid}?ttl=10000' \
--header "X-Cassandra-Token: {auth_token}" \
--header 'Content-Type: application/json' \
--data-raw ' {
  "okaydokie": "Now I have done it! We have a TTL at last!"
}'
