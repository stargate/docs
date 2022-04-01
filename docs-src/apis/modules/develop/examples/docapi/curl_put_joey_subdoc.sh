curl -L -X PUT '{base_doc_url}{base_doc_api}/{namespace}/collections/{collection}/{user1}' \
--header "X-Cassandra-Token: {auth_token}" \
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
