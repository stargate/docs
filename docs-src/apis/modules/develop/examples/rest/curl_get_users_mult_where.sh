curl -s -L -X GET '{base_rest_url}{base_rest_schema}/{rkeyspace}/{rtable}?where=\{"firstname":\{"$eq":"Janesha"\},"favorite_books":\{"$contains":"Emma"\}\}' \
--header "X-Cassandra-Token: {auth_token}" \
--header "Content-Type: application/json"
