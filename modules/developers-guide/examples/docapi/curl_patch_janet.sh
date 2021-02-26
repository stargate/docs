curl -L \
-X PATCH '{my_base_url}{my_base_api_path}/namespaces/myworld/collections/fitness/Janet' \
--header "X-Cassandra-Token: $AUTH_TOKEN" \
--header 'Content-Type: application/json' \
--data '{
    "firstname": "JanetLee",
    "lastname": "Doe"
}'
