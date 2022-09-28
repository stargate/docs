curl -L \
-X PATCH '{base_doc_url_v2}{base_doc_api}/{namespace}/collections/{collection}/{user1}/weights' \
--header "X-Cassandra-Token: {auth_token}" \
--header 'Content-Type: application/json' \
--data '{
    "reps": 10,
    "type": "squat",
    "weight": 350
}'
