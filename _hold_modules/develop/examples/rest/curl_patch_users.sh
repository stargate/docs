curl -s -L -X PATCH '{base_rest_url}{base_rest_schema}/{rkeyspace}/{rtable}/Mookie/Betts' \
-H "X-Cassandra-Token: $AUTH_TOKEN" \
-H 'Content-Type: application/json' \
-d '{
    "email": "mookie.betts.email@email.com"
}'
