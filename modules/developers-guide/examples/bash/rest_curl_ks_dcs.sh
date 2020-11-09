curl --location --request POST 'localhost:8082/v2/schemas/keyspaces' \
--header "X-Cassandra-Token: $AUTH_TOKEN" \
--header 'Content-Type: application/json' \
--data '{
    "name": "users_keyspace-dcs",
    "datacenters": [ {"name": "dc1"}, {"name": "dc2", "replicas": 5} ]
}'
