curl -L -X POST '{base_doc_url}{base_doc_schema}' \
-H "X-Cassandra-Token: {auth_token}" \
-H 'Content-Type: application/json' \
-d '{
    "name": "myworld_dcs",
    "datacenters": [ {"name": "dc1"}, {"name": "dc2", "replicas": 5} ]
}'
