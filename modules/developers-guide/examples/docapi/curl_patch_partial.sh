curl -L \
-X PATCH '{my_base_url}{my_base_api_path}/{my_namespace}/collections/{my_collection}/Joey' \
--header "X-Cassandra-Token: $AUTH_TOKEN" \
--header 'Content-Type: application/json' \
--data '{
      "firstname": "Joseph"
}'
