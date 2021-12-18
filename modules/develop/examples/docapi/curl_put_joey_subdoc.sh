curl -L -X PUT '{base_url}{base_doc_api}/{namespace}/collections/{collection}/Joey' \
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
