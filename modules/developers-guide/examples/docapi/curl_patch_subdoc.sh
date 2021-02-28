curl -L \
-X PATCH '{my_base_url}{my_base_api_path}/{my_namespace}/collections/{my_collection}/Joey/weights' \
--header "X-Cassandra-Token: $AUTH_TOKEN" \
--header 'Content-Type: application/json' \
--data '{
    "reps": 10,
    "type": "squat",
    "weight": 350
}'
