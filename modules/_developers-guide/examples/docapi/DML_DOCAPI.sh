curl --location \
--request POST 'localhost:8082/v2/namespaces/myworld/collections/fitness' \
--header "X-Cassandra-Token: $AUTH_TOKEN" \
--header 'Content-Type: application/json' \
--data '{
  "id": "some-stuff",
  "other": "This is nonsensical stuff."
}'

curl -L -X PUT 'localhost:8082/v2/namespaces/myworld/collections/fitness/Janet' \
--header "X-Cassandra-Token: $AUTH_TOKEN" \
--header 'Content-Type: application/json' \
--data '{
  "firstname": "Janet",
  "lastname": "Doe",
  "email": "janet.doe@gmail.com",
  "favorite color": "grey"
}

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

curl -L \
-X PATCH 'localhost:8082/v2/namespaces/myworld/collections/fitness/Joey' \
--header "X-Cassandra-Token: $AUTH_TOKEN" \
--header 'Content-Type: application/json' \
--data '{
      "firstname": "Joseph"
}'

curl -L \
-X PATCH 'localhost:8082/v2/namespaces/myworld/collections/fitness/Janet' \
--header "X-Cassandra-Token: $AUTH_TOKEN" \
--header 'Content-Type: application/json' \
--data '{
    "firstname": "JanetLee",
    "lastname": "Doe"
}'

curl -L \
-X PATCH 'http://localhost:8082/v2/namespaces/myworld/collections/fitness/Joey/weights' \
--header "X-Cassandra-Token: $AUTH_TOKEN" \
--header 'Content-Type: application/json' \
--data '{
    "reps": 10,
    "type": "squat",
    "weight": 350
}'

curl -X GET 'localhost:8082/v2/schemas/namespaces/myworld' \
--header "X-Cassandra-Token: $AUTH_TOKEN" \
--header 'Content-Type: application/json'

curl --location \
--request GET 'localhost:8082/v2/namespaces/myworld/collections/fitness?page-size=3' \
--header "X-Cassandra-Token: $AUTH_TOKEN" \
--header 'Content-Type: application/json'

curl -L -X GET 'localhost:8082/v2/namespaces/myworld/collections/fitness/Janet' \
 --header "X-Cassandra-Token: $AUTH_TOKEN" \
 --header 'Content-Type: application/json'

curl -L \
-X GET 'localhost:8082/v2/namespaces/myworld/collections/fitness/Joey' \
--header "X-Cassandra-Token: $AUTH_TOKEN" \
--header 'Content-Type: application/json'

curl -L -X  GET 'localhost:8082/v2/namespaces/myworld/collections/fitness?where=\{"firstname":\{"$eq":"JanetLee"\}\}' \
--header "X-Cassandra-Token: $AUTH_TOKEN" \
--header 'Content-Type: application/json'

curl -L -X  GET 'localhost:8082/v2/namespaces/myworld/collections/fitness/Joey/weights/type' \
--header "X-Cassandra-Token: $AUTH_TOKEN" \
--header 'Content-Type: application/json'

curl --location --request GET 'localhost:8082/v2/namespaces/myworld/collections/fitness/Joey/weights' \
--header "X-Cassandra-Token: $AUTH_TOKEN" \
--header 'Content-Type: application/json'

curl -L -X  GET 'localhost:8082/v2/namespaces/myworld/collections/fitness?where=\{"weights.type":\{"$eq":"bench%20press"\}\}' \
--header "X-Cassandra-Token: $AUTH_TOKEN" \
--header 'Content-Type: application/json'

curl -L -X  GET 'localhost:8082/v2/namespaces/myworld/collections/fitness?where=\{"weights.type":\{"$eq":"squat"\}\}' \
--header "X-Cassandra-Token: $AUTH_TOKEN" \
--header 'Content-Type: application/json'
