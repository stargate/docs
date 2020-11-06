curl -L \
-X PATCH 'localhost:8082/v2/namespaces/myworld/collections/fitness/Joey' \
--header "X-Cassandra-Token: $AUTH_TOKEN" \
--header 'Content-Type: application/json' \
--data '{
      "firstname": "Joseph"
}'
