curl -L -X POST '{my_base_url}{my_base_api_path}/schemas/namespaces' \
-H "X-Cassandra-Token: $AUTH_TOKEN" \
-H 'Content-Type: application/json' \
-d '{
    "name": "myworld_dcs",
    "datacenters": [ {"name": "dc1"}, {"name": "dc2", "replicas": 5} ]
}'
