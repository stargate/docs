curl -L -X PUT '{my_base_url}{my_base_api_path}/namespaces/myworld/collections/fitness/Martha' \
--header "X-Cassandra-Token: $AUTH_TOKEN" \
--header 'Content-Type: application/json' \
--data '{
    "firstname": "Martha",
    "lastname": "Smith",
    "weights": {
      "type": "bench press",
      "weight": 125,
      "reps": 12
  }
}'
