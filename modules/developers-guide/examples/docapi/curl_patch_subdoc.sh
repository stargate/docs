curl -L \
-X PATCH 'http://localhost:8082/v2/namespaces/myworld/collections/fitness/Joey/weights' \
--header "X-Cassandra-Token: $AUTH_TOKEN" \
--header 'Content-Type: application/json' \
--data '{
    "reps": 10,
    "type": "squat",
    "weight": 350
}'
