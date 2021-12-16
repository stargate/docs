curl -s -L -X POST {base_url}{base_rest_schema} \
-H "X-Cassandra-Token: $AUTH_TOKEN" \
-H "Content-Type: application/json" \
-d '{
    "name": "{rkeyspace}",
    "replicas": 1
}'
