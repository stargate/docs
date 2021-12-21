curl -s -L -X PUT '{base_rest_url}{base_rest_schema}/{rkeyspace}/{rtable}/Mookie/Betts' \
-H "X-Cassandra-Token: $AUTH_TOKEN" \
-H 'Content-Type: application/json' \
-d '{
    "email": "mookie.betts.new-email@email.com"
}'
