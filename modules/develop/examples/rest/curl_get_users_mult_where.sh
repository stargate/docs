curl -s -L -X GET '{base_url}{base_rest_schema}/{rkeyspace}/{rtable}?where=\{"firstname":\{"$eq":"Janesha"\},"favorite_books":\{"$contains":"Emma"\}\}' \
--header "X-Cassandra-Token: $AUTH_TOKEN" \
--header "Content-Type: application/json"
