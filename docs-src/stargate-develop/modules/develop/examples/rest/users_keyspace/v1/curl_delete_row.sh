curl -s -L -X DELETE {base_rest_url}{base_rest_schema}/{rkeyspace}/{rtable}/{user1fn}/{user1ln} \
-H "X-Cassandra-Token: {auth_token}" \
-H "Content-Type: application/json"
