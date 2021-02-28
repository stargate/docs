curl -s -L -X GET '{my_base_url}{my_base_api_path}/{my_keyspace}/{my_table}?where=\{"firstname":\{"$eq":"Janesha"\},"favorite_books":\{"$contains":"Emma"\}\}' \
--header "X-Cassandra-Token: $AUTH_TOKEN" \
--header "Content-Type: application/json"
