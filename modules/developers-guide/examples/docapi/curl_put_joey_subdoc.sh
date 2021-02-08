curl -L -X PUT 'localhost:8082/v2/namespaces/myworld/collections/fitness/Joey' \
--header "X-Cassandra-Token: $AUTH_TOKEN" \
--header 'Content-Type: application/json' \
--data '{
    "firstname": "Joey",
    "lastname": "Doe",
    "weights": {
      "type": "bench press",
      "weight": 150,
      "reps": 15
  }
}'
