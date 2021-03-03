curl --location \
--request POST --url {my_base_url}{my_base_api_path}/{my_namespace}/collections/{my_collection} \
--header "X-Cassandra-Token: $AUTH_TOKEN" \
--header 'Content-Type: application/json' \
--data '{
  "id": "some-stuff",
  "other": "This is nonsensical stuff."
}'
