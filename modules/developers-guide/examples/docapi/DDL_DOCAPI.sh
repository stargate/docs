curl -L -X GET 'localhost:8082/v2/schemas/namespaces' \
-H 'X-Cassandra-Token: $AUTH_TOKEN' \
-H 'Content-Type: application/json'

curl -L -X POST 'localhost:8082/v2/schemas/namespaces' \
-H 'X-Cassandra-Token: $AUTH_TOKEN' \
-H 'Content-Type: application/json' \
-d '{
    "name": "myworld",
    "replicas": 1
}'

curl -L -X DELETE 'localhost:8082/v2/schemas/namespaces/myworld' \
--header "X-Cassandra-Token: $AUTH_TOKEN" \
--header 'Content-Type: application/json'

curl -X GET 'localhost:8082/v2/schemas/namespaces/myworld' \
--header "X-Cassandra-Token: $AUTH_TOKEN" \
--header 'Content-Type: application/json'

curl -L -X POST 'localhost:8082/v2/schemas/namespaces' \
-H "X-Cassandra-Token: $AUTH_TOKEN" \
-H 'Content-Type: application/json' \
-d '{
    "name": "myworld_dcs",
    "datacenters": [ {"name": "dc1"}, {"name": "dc2", "replicas": 5} ]
}'

curl --location --request POST 'localhost:8082/v2/schemas/namespaces' \
--header "X-Cassandra-Token: $AUTH_TOKEN" \
--header 'Content-Type: application/json' \
--data '{
    "name": "myworld",
    "replicas": 2
}'

curl --location --request POST 'localhost:8082/v2/schemas/namespaces' \
--header "X-Cassandra-Token: $AUTH_TOKEN" \
--header 'Content-Type: application/json' \
--data '{
    "name": "myworld"
}'
