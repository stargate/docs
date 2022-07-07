curl -L -X PUT '{base_doc_url}{base_doc_api}/{namespace}/collections/{collection}/Martha' \
--header "X-Cassandra-Token: {auth_token}" \
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
