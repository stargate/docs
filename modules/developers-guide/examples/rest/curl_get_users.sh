curl -s -L -X GET '{base_url}{base_rest_schema}/{rkeyspace}/{rtable}?where=\{"firstname":\{"$in":\["Janesha","Mookie"\]\}\}' \
-H "X-Cassandra-Token: $AUTH_TOKEN" \
-H "Content-Type: application/json"
