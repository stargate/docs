curl -L \
-X PATCH '{base_doc_url}{base_doc_api}/{namespace}/collections/{collection}/Joey/weights' \
--header "X-Cassandra-Token: $AUTH_TOKEN" \
--header 'Content-Type: application/json' \
--data '{
    "reps": 10,
    "type": "squat",
    "weight": 350
}'
