curl -L -X PUT 'localhost:8082/v2/namespaces/myworld/collections/fitness/Janet' \
--header "X-Cassandra-Token: $AUTH_TOKEN" \
--header 'Content-Type: application/json' \
--data '{
  "firstname": "Janet",
  "lastname": "Doe",
  "email": "janet.doe@gmail.com",
  "favorite color": "grey"
}'
